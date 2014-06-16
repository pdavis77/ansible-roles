Ansible Roles for ELK Stack for Debian & CentOS/RedHat environments
Desc: I couldn't find a collection of ansible roles made for CentOS and since I work with CentOS & Ubuntu this made sense to create and share.
Authored by: Paul Davis
GitHub: https://github.com/pdavis77/ansible-roles

Requires: Ansible 1.6+
Compatible with:
- Ubuntu 12.04+
- CentOS 6.4+

Roles included:
- common: useful tools
- nginx
- oracle_jdk: best for use w/ ES
- redis
- elasticsearch
- logstash
- kibana

Inventory groups:
- webserver			# web server nodes
- redis				# redis nodes
- logstash			# logstash nodes
- es-master 		# ES Master nodes w/o data
- es-master-data	# ES Master nodes w/ data
- es-data 			# ES Data nodes
- es-search 		# ES Search nodes

Notes:
- Run tasks for a specific tag by adding the vars tag to your execution (--tags="vars,<tag>")

Guidelines used:
1) Must work in Debian & RedHat distros
	Distro specific items belong in appropriately named  files (Debian or RedHat)
2) Roles may contain more than one app, and must be easily seperable
	Roles that contain more than one app (i.e. common), Distro specific files are prefixed with app name
3) Allow execution of just one app or function grouping
	Provide tags for tasks of each app or set of apps grouped by common function (i.e. tools)
4) Be resilient in operation
	Check non package manager tasks to prevent additional manual interaction