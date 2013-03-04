use Test::More tests => 2;
use SUTL::TimeUtl;

my $time = new SUTL::TimeUtl;


$time->set_timestamp;

is($time->get_current_timestamp_str,$time->get_timestamp_str);

is(join('-',$time->get_add_date_fmt(2001,1,1,2)),"2001-01-03");
