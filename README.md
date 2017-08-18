# namepaces-cgroups-playground
Just trying out some of the stuff that makes a container tick. If you've never tried building a container or compiling a kernel from a t2 micro amazon instance, I strongly recommend it.
rootfs.tar is a custom baked container with minimal packages installed. It contains curl,nginx,php-fpm,lynx,grep(pcre enabled) apart from a minimal busybox based installation. The repo contains a simple shell script to launch the container in a chrooted environment placed in  a diffeent  net and pid namespace. It creates a liux bridge to route traffic between containers and uses nat to communnicate outside the host.

#cgroups

A shellscript to spawn up a process within a cgroup with memory and cpu utilization limits set.
