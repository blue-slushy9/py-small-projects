#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

# 'FROM' sets the base image for subsequent instructions;
# alpine is the image repository, '3.20' is the version
FROM alpine:3.20

# https://ftp.gnu.org/gnu/bash/?C=M;O=D
ENV _BASH_VERSION 3.2.57
ENV _BASH_BASELINE 3.2.57
ENV _BASH_BASELINE_PATCH 57
# https://ftp.gnu.org/gnu/bash/bash-3.2-patches/?C=M;O=D
ENV _BASH_LATEST_PATCH 57
# prefixed with "_" since "$BASH..." have meaning in Bash parlance

# RUN executes commands within a new layer on top of the current image and commits the results;
# set is a bash command that configures shell options within a script or interactive shell session;
# the switch -e causes the command to stop immediately if any error occurs during execution;
# the switch -u treats unset variables as errors---if a variable is referenced but not defined, the build process will fail;
# the switch -x causes the shell to output each command being run;
RUN set -eux; \
	\
	apk add --no-cache --virtual .build-deps \
                # Bison is a general-purpose parser generator, converts a grammar description into a C/C++ or Java program
                # that can parse that grammar
		bison \
                # coreutils is a package that provides a collection of basic and essential command-line utilities
		coreutils \
                # dpkg is a a Debian tool, but this Dockerfile uses it to build bash from source
		dpkg-dev dpkg \
                # GNU Compiler Collection, supports various programming languages but mostly C/C++
		gcc \
                # 'libc-dev' provides the development files for the C standard library (libc), used for compiling C programs
		libc-dev \
                # 'make' is a build automation tool, used to automate the process of building executable programs and libraries
                # from source code
		make \
                # 'ncurses-dev' is a development package for the 'new curses', a library that provides APIs for creating text-based
                # user interfaces (TUIs)
		ncurses-dev \
		# 'patch' is a utility program used for applying diff/patch files to original files, in order to update or modify them
                patch \
                # 'tar' is a utility for working with archived files, i.e. tarballs; tarballs are created by combining multiple files 
                # and directories into a single file
		tar \
	; \
	\
        # 'wget' can be used to retrieve/download files using HTTP/S and FTP;
        # 'wget' downloads a file and saves it as bash.tar.gz; '$_BASH_BASELINE' is a variable containing the version number, which was set
        # as an environment variable (ENV) at the top of this file; bash simply inserts the specificed version number into the URLs below;
	wget -O bash.tar.gz "https://ftp.gnu.org/gnu/bash/bash-$_BASH_BASELINE.tar.gz"; \
	wget -O bash.tar.gz.sig "https://ftp.gnu.org/gnu/bash/bash-$_BASH_BASELINE.tar.gz.sig"; \
	\
        # ':' is a no-op command in bash, it does nothing but return a successful exit status; it is used here to assign variables without 
        # issuing commands; 
        # Parameter expansion syntax is '${variable:=default}' and is used to assign a value IF there is no value currently set or if the 
        # value is null---else if a value is already set, then the variable conserves its current value;
        # Create variable '_BASH_BASELINE_PATCH' and assign it a default value of 0; create variable '_BASH_LATEST_PATCH' and assign it a
        # default value of 0; the 0 value signifies no patches have been applied, so even the first patch (1) would be greater than 0;
	: "${_BASH_BASELINE_PATCH:=0}" "${_BASH_LATEST_PATCH:=0}"; \
        # If the latest patch is newer than the baseline patch...
	if [ "$_BASH_LATEST_PATCH" -gt "$_BASH_BASELINE_PATCH" ]; then \
                # -p switch creates any parent directories needed to arrive at target directory, but none are specified here?
		mkdir -p bash-patches; \
                # Command substitution $((...)) runs what's inside and returns its output; 'printf' is used for formatted printing; 
                # '%d' means print a decimal (integer) number; '03' means pad with 0s to a width of 3 digits; we add 1 to the baseline
                # patch number because the baseline patch has already been applied, so we only need to download any newer patches than it;
		first="$(printf '%03d' "$(( _BASH_BASELINE_PATCH + 1 ))")"; \
		last="$(printf '%03d' "$_BASH_LATEST_PATCH")"; \
                # '%.*' is a parameter expansion operation that removes a dot followed by any characters from the end of the string
		majorMinor="${_BASH_VERSION%.*}"; \
                # 'seq -w' generates sequences of numbers, all with an equal width, by adding leading zeros; it will generate all values
                # between $first and $last (inclusive), 
		for patch in $(seq -w "$first" "$last"); do \
                        # Substitute _BASH_VERSION for ${majorMinor}; the first '/' indicates substitution, the second '/' means
                        # replace all occurrences, the '.' is the pattern we're looking for, the empty string after '/' is what
                        # we're replacing the '.'s with, i.e. nothing; 
			url="https://ftp.gnu.org/gnu/bash/bash-$majorMinor-patches/bash${majorMinor//./}-$patch"; \
                        # example: https://ftp.gnu.org/gnu/bash/bash-3.2.57-patches/bash3257-01
			wget -O "bash-patches/$patch" "$url"; \
			wget -O "bash-patches/$patch.sig" "$url.sig"; \
		done; \
	fi; \
	\
        
        # PGP configuration
        # APK is Alpine Package Manager; --no-cache means don't download packages that are already
        # saved in the local cache; --virtual creates a virtual directory called .gpg-deps to bundle
        # together all of the packages required to install and run gnupg, for easy deletion;
	apk add --no-cache --virtual .gpg-deps gnupg; \
        # export is used to make variables available to child processes;
        # mktemp -d creates a temporary directory, usually in /tmp, in this case GNUPGHOME
	export GNUPGHOME="$(mktemp -d)"; \
# gpg: key 64EA74AB: public key "Chet Ramey <chet@cwru.edu>" imported
        # --batch tells GPG to run in non-interactive mode, which is often used in scripts;
        # --keyserver specifies which keyserver to use, in this case keyserver.Ubuntu.com;
        # --recv-keys tells GPG to receive (download) public keys; 7C0...4AB is the key ID GPG is asked to receive;
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 7C0135FB088AAF6C66C650B9BB5869F064EA74AB; \
        # Verifies signature file against tarball
	gpg --batch --verify bash.tar.gz.sig bash.tar.gz; \
	rm bash.tar.gz.sig; \
        # if a directory named 'bash-patches' exists...
	if [ -d bash-patches ]; then \
                # iterate over all .sig files in 'bash-patches'
		for sig in bash-patches/*.sig; do \
                        # Removes '.sig' extension from each signature file, then assigns to variable 'p'
			p="${sig%.sig}"; \
                        # Verifies signature from .sig file against the file itself
			gpg --batch --verify "$sig" "$p"; \
			# Delete signature file since we no longer need it
                        rm "$sig"; \
		done; \
	fi; \
        # Kills all running GPG components
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
        # '--no-network' option prevents APK from accessing the network during deletion
	apk del --no-network .gpg-deps; \
	\
        # /PGP

	mkdir -p /usr/src/bash; \
        # Tool for working with tar files
	tar \
		--extract \
		--file=bash.tar.gz \
                # '--strip-components' removes the specified number of leading direcories, in this case 1;
                # ergo, the parent directory in which 'bash.tar.gz' resides would be removed from its filepath;
		--strip-components=1 \
		--directory=/usr/src/bash \
	; \
	rm bash.tar.gz; \
	\
	if [ -d bash-patches ]; then \
                # Installs 'patch' utility, used to apply diff/patch files to original files;
		apk add --no-cache --virtual .patch-deps patch; \
		for p in bash-patches/*; do \
                        # Apply diff/patch file
			patch \
				--directory=/usr/src/bash \
                                # '--input' specifies diff/patch file to be applied; 'readlink -f' retrieves the
                                # full filepath of the file $p;
				--input="$(readlink -f "$p")" \
                                # Do not strip any leading directories/components from patch file, often used to preserve 
                                # original and patch directory structures;
				--strip=0 \
			; \
			rm "$p"; \
		done; \
		rmdir bash-patches; \
		apk del --no-network .patch-deps; \
	fi; \
	\
	cd /usr/src/bash; \
        # 'dpkg-architecture' is used to query package architecture information, '--query DEB_BUILD_GNU_TYPE' requests the GNU architecture
        # type, e.g. i386, amd64, armhf, arm64;
	gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
# update "config.guess" and "config.sub" to get more aggressively inclusive architecture support
        # 'config.guess' and 'config.sub' are files used in the autoconf build system, they are primarily used to determine the system architecture
        # and configuration details during the build process; autoconf is a tool used to produce configuration scripts for building software packages
        # on Unix-like systems, e.g. Makefile;
        # Iterate over the two config files, pass each filename to the wget command in order to update the config scripts to the latest versions,
        # based on the git commit hash found in the URL
	for f in config.guess config.sub; do \
		wget -O "support/$f" "https://git.savannah.gnu.org/cgit/config.git/plain/$f?id=7d3d27baf8107b630586c962c057e22149653deb"; \
	done; \
        # 'configure' is a script commonly found in source code distributions, used to prepare the software for building on a specific system
	./configure \
		# '--build' specifies the system architecture
                --build="$gnuArch" \
                # Enables support for the readline library, which provides line editing and history capabilities for interactive programs;
                # enabling readline provides command-line editing, searchable command history, and other interactive shell features
		--enable-readline \
		--with-curses \
# musl does not implement brk/sbrk (they simply return -ENOMEM)
# bash: xmalloc: locale.c:81: cannot allocate 18 bytes (0 bytes allocated)
                # disables bash's custom memory allocator (probably due to above error developer seemed to be getting)
		--without-bash-malloc \
        # OR operator
	|| { \  # If the configuration fails, this command will output the contents of the config.log file to standard error (stderr)
		cat >&2 config.log; \
                # 'false' always returns the failure exit status code: 1; in this usage, it ensures the entire command fails 
                # (hence the OR operator)
		false; \
	}; \
# parallel jobs workaround borrowed from Alpine :)
        # 'make' is used to create files or directories; 'y.tab.c' is part of the process of building a parser for a programming
        # language or configuration file format; 'libbuiltins.a' is a static library that probably contains compiled code for built-in
        # commands or functions
	make y.tab.c; make builtins/libbuiltins.a; \
        # 'make -j' is used to run multiple jobs/commands simultaneously; 'nproc' returns the number of CPU or CPU cores in the system;
        # ergo, this command tells bash to run as many jobs as there are processing cores in the system
	make -j "$(nproc)"; \
        # 'make install' runs the install target defined in the project's Makefile; the target usually copies the compiled binaries,
        # libraries, and other necessary files to their final destinations in the system
	make install; \
	cd /; \
	rm -r /usr/src/bash; \
	\
# delete a few installed bits for smaller image size
	rm -rf \
                # '.../*.html' are documentation files for the bash shell; '.../doc/' is a common directory path for
                # storing documentation files for installed software
		/usr/local/share/doc/bash/*.html \
                # '.../info' stores info documentation files, e.g. .info, .info.gz, .dir; system, programming, software docs
		/usr/local/share/info \
                # '.../locale' stores localization files for software installed in the '/usr/local' hierarchy
		/usr/local/share/locale \
                # '.../man' stores manual pages for software installed on the system
		/usr/local/share/man \
	; \
	\
	runDeps="$( \
                # The 'scanelf' utility is used to scan ELF (Executable and Linkable Format) files;
                # '--needed' shows the needed files (i.e. dependencies) of the ELF files;
                # '--nobanner' suppresses the output of the version and copyright banner;
                # '--format' specifies output format, '%n' prints the filename of the ELF, '#' as literal separator,
                # 'p' at the end is equivalent to '%p', which prints dependencies; '--recursive' refers to scan type;
                # '/usr/local' stores locally installed software and related files, it's designed to keep locally compiled
                # or manually installed software separate from the software managed by the system's package manager
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
                        # '|' is the pipe operator; 'tr' is the translate command, it will replace all ','s with '\n's
			| tr ',' '\n' \
                        # 'sort -u' sorts the input strings alphabetically and returns only unique results, i.e. removes duplicates
			| sort -u \
                        # 'system()' runs the shell command '[ -e /usr/local/lib/" $1 " ]', which checks in the directory path 
                        # '/usr/local/lib/'  for the existence of the file being referenced by "$1", which in awk is the first field
                        # of the current input line; if it exists, it skips that library with 'next'; if it doesn't exist, it prints 
                        # 'so:' followed by the library name (because $1 points to it)
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
        # $runDeps is an array of packages to be installed, the runtime dependencies for bash
	apk add --no-network --virtual .bash-rundeps $runDeps; \
	apk del --no-network .build-deps; \
	\
        # '[...]' are conditional checks; 'which bash' is a command that locates the executable file associated with the command 'bash'; 
        # in this case, it compares the two filepaths and returns 0 if they are a match
	[ "$(which bash)" = '/usr/local/bin/bash' ]; \
	# Returns currently installed version of bash, based on the 'bash' command (there may still be multiple versions installed on the system)
        bash --version; \
        # 'bash -c' runs a string as a command, in this case the 'echo...'; 'BASH_VERSION' is a built-in variable in bash that returns the version
        # information of the current bash instance; '%%' is a parameter expansion operator that removes a pattern from the end of a string;
        # the brackets enclose the pattern we are looking for; the symbol '^' means negate; '0-9.' means any digit or period; '*' is a wildcard,
        # in this case it means to match any character and any number of characters; the entire pattern '%%[^0-9.]*' means remove anything that is 
        # NOT a digit or period, which then gets compared to the _BASH_VERSION environment variable and returns 0 if they match;
        # Example: if echo "$BASH_VERSION" returns 5.0.17(1)-release, that gets shortened to 5.0.17
	[ "$(bash -c 'echo "${BASH_VERSION%%[^0-9.]*}"')" = "$_BASH_VERSION" ]; \
        # 'bash -c' will run 'help', which gets directed to '/dev/null'; /dev/null is a file and virtual device that discards all data written to it
        # and provides no data when read; it is often used in scripts to test exit status (e.g. success/0) when you don't actually need the output
	bash -c 'help' > /dev/null

# 'docker...sh' is a script that defines the default behavior of a container when it starts;
# this command copies the file from the working directory (where you run 'docker build') to the target,
# which is inside of the container; we move it here so that it is accessible and can be run at container startup;
COPY docker-entrypoint.sh /usr/local/bin/
# 'ENTRYPOINT' defines the executable process that runs when the container starts
ENTRYPOINT ["docker-entrypoint.sh"]
# 'CMD' defines the default arguments that are passed to the entrypoint script
CMD ["bash"]
