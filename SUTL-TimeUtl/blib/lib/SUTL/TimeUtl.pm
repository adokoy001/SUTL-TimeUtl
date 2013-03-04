package SUTL::TimeUtl;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.1.0');

# Other recommended modules (uncomment to use):
#  use IO::Prompt;
#  use Perl6::Export;
#  use Perl6::Slurp;
#  use Perl6::Say;

use Time::HiRes;
use Time::Local;




# create method
sub new{
    my $pkg = shift;
    bless{
    sec => undef,
    min => undef,
    hour => undef,
    day => undef,
    month => undef,
    year => undef,
    hires01 => undef,
    proct => undef,
    totalsec => undef
    },$pkg;
}

# set current timestamp to member variables.
sub set_timestamp{
    my $self = shift;
    my $totalsec = time;
    ($self->{sec},
     $self->{min},
     $self->{hour},
     $self->{day},
     $self->{month},
     $self->{year}) = (localtime($totalsec))[0,1,2,3,4,5];
    $self->{year} += 1900;
    $self->{month}++;
    $self->{totalsec} = $totalsec;
}

# get current timestamp
sub get_current_timestamp_str{
    my $self = shift;
    my $times = &get_current_timestamp_array;
    my $output_str = sprintf("%04d-%02d-%02d %02d:%02d:%02d",
                             $times->[5],
                             $times->[4],
                             $times->[3],
                             $times->[2],
                             $times->[1],
                             $times->[0]
        );
    return($output_str);
}

# get current date
sub get_current_date_str{
    my $self = shift;
    my $times = &get_current_timestamp_array;
    my $output_str = sprintf("%04d-%02d-%02d",
                             $times->[5],
                             $times->[4],
                             $times->[3]
        );
    return($output_str);
}

# get current timestamp array
sub get_current_timestamp_array{
    my ($sec,$min,$hour,$day,$month,$year) = (localtime(time))[0,1,2,3,4,5];
    $year += 1900;
    $month++;
    my $time_array = [$sec,$min,$hour,$day,$month,$year];
    return($time_array);
}

# starting inner stop watch
sub start_watch{
    my $self = shift;
    $self->{hires01} = (Time::HiRes::time)[0];
}

# get date array from member variable
sub get_date_array{
    my $self = shift;
    return($self->{year},$self->{month},$self->{day});
}

# get time array from member variable
sub get_time_array{
    my $self = shift;
    return($self->{hour},$self->{min},$self->{sec});
}

# get timestamp array from member variable
sub get_timestamp_array{
    my $self = shift;
    return($self->{year},$self->{month},$self->{day},$self->{hour},$self->{min},$self->{sec});
}

# stopping inner stop watch
sub stop_watch{
    my $self = shift;
    my $t = (Time::HiRes::time)[0];
    $self->{proct} = ($t - $self->{hires01});
}

# get timestamp fmt YYYY-MM-DD hh:mm:ss
sub get_timestamp_str{
    my $self = shift;
    my $str = sprintf("%04d-%02d-%02d %02d:%02d:%02d",$self->{year},$self->{month},$self->{day},$self->{hour},$self->{min},$self->{sec});
    return($str);
}

# get timestamp japanese fmt.
sub get_timestamp_str_J{
    my $self = shift;
    my $str = sprintf("%04d年%02d月%02d日 %02d:%02d:%02d",$self->{year},$self->{month},$self->{day},$self->{hour},$self->{min},$self->{sec});
  return($str);
}

# get date fmt YYYY-MM-DD
sub get_date_str{
    my $self = shift;
    my $str = sprintf("%04d-%02d-%02d",$self->{year},$self->{month},$self->{day});
    return($str);
}

# get date japanese fmt.
sub get_date_str_J{
    my $self = shift;
    my $str = sprintf("%04d年%02d月%02d日",$self->{year},$self->{month},$self->{day});
    return($str);
}

# get time fmt hh:mm:ss
sub get_time_str{
    my $self = shift;
    my $str = sprintf("%02d:%02d:%02d",$self->{hour},$self->{min},$self->{sec});
    return($str);
}

# get string week day 
sub get_datetoweek{
    my $self = shift;
    my $str = shift;
    my @weeks = ('SUN','MON','TUE','WED','THU','FRI','SAT');
    my ($year,$month,$day) = split('-',$str);
    if($month == 1 or $month == 2){
	$year--;
	$month += 12;
    }
    my $ind =  ($year + int($year / 4) - int($year/100) + int($year / 400) + int((13 * $month + 8) / 5) + $day) % 7;
    return($weeks[$ind]);
}

# get japanese expression week day
sub get_datetoweek_J{
    my $self = shift;
    my $str = shift;
    my @weeks = ('日','月','火','水','木','金','土');
    my ($year,$month,$day) = split('-',$str);
    if($month == 1 or $month == 2){
	$year--;
	$month += 12;
    }
    my $ind =  ($year + int($year / 4) - int($year/100) + int($year / 400) + int((13 * $month + 8) / 5) + $day) % 7;
    return($weeks[$ind]);
}

# get process time (from HiRes)
sub get_proctime{
    my $self = shift;
    return($self->{proct});
}

# calculating added date (24*60*60 sec)
# usage: get_add_date(base_year,base_month,base_day,additional days you wanted).
# And then it returns 3 values
sub get_add_date{
    my $self = shift;
    my $base_year = shift;
    my $base_month = shift;
    my $base_day = shift;
    my $add_day = shift;
    my $insec = timelocal(1,0,0,$base_day,$base_month - 1,$base_year) + (60*60*24)*$add_day;
    my ($out_day,$out_month,$out_year) = (localtime($insec))[3,4,5];
    return($out_year+1900,$out_month+1,$out_day);
}


# calculating added date with fmt YYYY-MM-DD
# usage: same as get_add_date()
# it returns zero filled strings array.
sub get_add_date_fmt{
    my $self = shift;
    my $base_year = shift;
    my $base_month = shift;
    my $base_day = shift;
    my $add_day = shift;
    my $insec = timelocal(1,0,0,$base_day,$base_month - 1,$base_year) + (60*60*24)*$add_day;
    my ($day,$month,$year) = (localtime($insec))[3,4,5];
    my $out_day = sprintf("%02d",$day);
    my $out_month = sprintf("%02d",$month+1);
    my $out_year = sprintf("%04d",$year+1900);
    return($out_year,$out_month,$out_day);
}

# YYYY-MM-DD hh:mm:ss fmt to unix time (sec)
sub ts_to_sec{
    my ($input) = @_;
    my ($date,$times) = split(' ',$input);
    my ($year,$month,$day) = split('-',$date);
    my ($hour,$min,$sec) = split(':',$times);
    return(timelocal($sec,$min,$hour,$day,$month - 1,$year));
}

# get differences of 2 inputed date.
sub get_diff_date{
    my $self = shift;
    my $date01 = shift;
    my $date02 = shift;
    my @date01array = split('-',$date01);
    my @date02array = split('-',$date02);
    my $secdate01 = timelocal(1,0,0,$date01array[2],$date01array[1] - 1,$date01array[0]);
    my $secdate02 = timelocal(1,0,0,$date02array[2],$date02array[1] - 1,$date02array[0]);
    my $diffday = int(($secdate02 - $secdate01)/(3600*24));
    return($diffday);
}

# add 1 day for member variables.
sub add_day{
    my $self = shift;
    $self->{totalsec} += 24*60*60;
    my ($sec,$min,$hour,$day,$month,$year) = (localtime($self->{totalsec}))[0,1,2,3,4,5];
    $month++;
    $year += 1900;
    $self->{sec} = $sec;
    $self->{min} = $min;
    $self->{hour} = $hour;
    $self->{day} = $day;
    $self->{month} = $month;
    $self->{year} = $year;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

SUTL::TimeUtl - Simplified Time Utility Functions


=head1 VERSION

This document describes SUTL::TimeUtl version 0.1.0


=head1 SYNOPSIS

    use SUTL::TimeUtl;

    my $timer = new SUTL::TimeUtl;
    $timer->set_timestamp; # set current timestamp to member variables.
    $timer->get_timestamp_str; # get timestamp YYYY-MM-DD format from member variables.
    $timer->start_watch; # starting inner time watch.
    $timer->stop_watch; # stopping inner time watch.
    $timer->get_proctime; # get time interval between starting and stopping time watch.

    $timer->get_current_timestamp_str; # get current timestamp instantly.
  
  
=head1 DESCRIPTION

This program for calculating the date-time is just simplified utility module.

Example: 
date inclement, date declement, date difference, get YYYY-MM-DD format, etc...


=head1 DEPENDENCIES

Time::HiRes

Time::Local


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-sutl-timeutl@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Toshiaki Yokoda  C<< <adokoy001@gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, Toshiaki Yokoda C<< <adokoy001@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
