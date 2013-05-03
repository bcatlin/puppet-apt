#puppet-apt

####Table of Contents

1. [Overview - What is the puppet-apt module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with puppet-apt](#setup)
    * [What puppet-vmwaretools affects](#what-puppet-apt-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet-apt](#beginning-with-registry)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module handles various `apt` configuration tasks, including adding repositories and keys.

##Module Description

This module provides some (but not all) configuration for `apt` - the Debian-based package management system. 

##Setup

###What puppet-vmwaretools affects

* Configures a proxy in `/etc/apt/apt.conf.d` if necessary.
* Writes the main `/etc/apt/sources.list` file with the configured localisation, and enables/disables additional Canonical repositories.
* Includes definitions for `apt` repositories and keys, allowing Puppet to manage the installation of PPA repositories.
* Adds a Puppet `exec` object that can be called to trigger an `apt-get update`.

###Setup Requirements

* Must be run on a Debian-based operating system - no checks within the module verify the underlying O/S.

###Beginning with puppet-apt

To accept default parameters:

    include apt

##Usage

* Parameters are explained in-depth in the `manifests/params.pp` file.
* I will be migrating to a parameterised-class structure in future versions.

##Reference

###Classes:
* `apt::params` - Declares all parameters for the module
* `apt::proxy` - Optionally configures an HTTP proxy for use with `apt`
* `apt::update` - Declares an `exec` for use in triggering an `apt-get update`
* `apt::sources` - Deploys a customised `/etc/apt/sources.list` file
* `apt::key` - Defines an `apt` repository key, downloadable from HTTP or specified on instantiation'
* `apt::customrepo` - Defines a custom repository, using a static (non-templated) file served from Puppet's filebucket as the `.list` file. Optionally can install a key via the `apt::key` definition.

##Limitations

###Supported Operating Systems:
* Debian family only (Ubuntu 12.04 LTS tested, other reports appreciated)

##Development

* Copyright (C) 2013 Craig Watson - <craig@cwatson.org>
* Distributed under the terms of the GNU General Public License v3 - see LICENSE file for details.
* Further contributions and testing reports are extremely welcome - please submit a pull request or issue on [GitHub](https://github.com/craigwatson/puppet-apt)

##Release Notes

* 0.0.1 - First PuppetForge release!
