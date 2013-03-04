use Test::More tests => 1;
use SUTL::TimeUtl;

my $obj = new SUTL::TimeUtl;


my $array = $obj->get_timestamp_array;

my $output_str_test = sprintf("%04d-%02d-%02d",
			      $array->[5],
			      $array->[4],
			      $array->[3]
    );


is($obj->get_date_str,,$output_str_test);

