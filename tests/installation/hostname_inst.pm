# SUSE's openQA tests
#
# Copyright © 2016 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

use base "y2logsstep";
use strict;
use warnings;
use testapi;

sub run() {
    my $self = shift;

    assert_screen "before-package-selection";

    select_console('install-shell');

    if (my $expected_install_hostname = get_var('EXPECTED_INSTALL_HOSTNAME')) {
        # EXPECTED_INSTALL_HOSTNAME contains expected hostname YaST installer
        # got from environment (DHCP, 'hostname=' as a kernel cmd line argument
        assert_script_run "test \"\$(hostname)\" == $expected_install_hostname";
    }
    else {
        # 'install' is the default hostname if no hostname is get from environment
        assert_script_run 'test "$(hostname)" == "install"';
    }
    save_screenshot;

    select_console('installation');

    assert_screen "inst-returned-to-yast";
}

1;
# vim: set sw=4 et: