use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use PDL::Core::Dev;

# Makefile has targets 'cleanall' and 'distcleanall'.
# These do clean and distclean in module distribution

my $matlab_package = ['matlab.pd', 'Matlab', 'PDL::IO::Matlab'];
my %hash = pdlpp_stdargs($matlab_package);

my %more_items = (
    NAME                => 'PDL::IO::Matlab',
    AUTHOR              => q{John Lapeyre <jlapeyre@cpan.org>},
    VERSION_FROM        => 'matlab.pd',
    ABSTRACT_FROM       => 'matlab.pd',
    PL_FILES            => {},
    LIBS => [ '-lmatio' ],
    PREREQ_PM => {
        'Test::More' => 0,
        'PDL' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => ' PDL-IO-Matlab-* Matlab.* tst.mat testf.mat ' },
);

map { $hash{$_} = $more_items{$_} } keys %more_items;

sub MY::postamble {  pdlpp_postamble($matlab_package)};


WriteMakefile( %hash );


if(exists $ARGV[0] && $ARGV[0] eq 'README.pod')
{
  print STDERR "Writing README.pod\n";
  open README, '>README.pod'  or die "Couldn't open README.pod";
#  print README $POD_header;

  foreach my $mod  ('Matlab.pm') {
      open MOD, $mod or die "Couldn't open main module";
      while (<MOD>)
      {
          if (/^=/../^=cut/)
          { print README; }
      }
      close(MOD);
  }
  close(README);
}
