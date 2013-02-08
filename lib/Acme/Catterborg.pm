package Acme::Catterborg;

use strict;
use warnings;

use Acme::LOLCAT;
use Lingua::EN::Keywords qw(keywords);
use Lingua::EN::Splitter qw(words);
use WWW::Google::Images;

our $VERSION = 0.01;

=head1 NAME

Acme::Catterborg - Your lolcats will be assimilated

=head1 SYNOPSIS

  use Acme::Catterborg qw(meow);
  meow( "i am feeling sleepy" );

=head1 FUNCTIONS

=head2 meow

Given a string, it returns a relevant cat picture. That's really all there is to it.

=cut

sub meow {
    my ($string) = @_;

    my $word = extract_magic_phrase($string);
    my $pic  = get_cat_picture($word);
    return $pic->content_url;
}

sub get_cat_picture {
    my $word = shift;
    my @pics = get_cat_pictures( $word );

    return $pics[ int rand @pics ];
}

sub get_cat_pictures {
    my $word   = shift;
    my $google = WWW::Google::Images->new(
        server => 'images.google.com',
    );

    # TODO lolcat gives more accurate results, cat gives a greater variety of cat pics
    my $result = $google->search("$word lolcat", limit => 10);
    my @results;
    while (my $image = $result->next) {
        push @results, $image;
    }

    return @results;
}

sub extract_magic_phrase {
    my $string   = shift;
    my @keywords = grep { $_ } keywords( $string );
       @keywords = sort { is_catlike($b) cmp is_catlike($a) } @keywords;
    # TODO it might be a phrase, "ceiling cat", etc.
    my $word = shift @keywords;

    debug("$string => $word");

    return $word;
}

sub is_catlike {
    my $word = shift;
    # TODO: soundex match, cheeseburger => cheezburger
    my @okee = qw(
        cheeseburger cheezburgur cheezburger cheez cheese ceiling ceeling seeling
    );
    return 1 if grep { $_ eq $word } @okee;
}

sub debug {
    my $msg = shift;
    return unless $ENV{CEILING_CAT_POWERS};
    print STDERR translate($msg) . "\n";
}

=head1 AUTHOR

Michael Aquilina

David Orr

=cut

1;

