package Cubes;

use Mojo::Base 'Mojo';
use Mojo::Command;

# All the complexities of CGI, PSGI, HTTP and WebSockets get reduced to a
# single method call!
sub handler {
    my ($self, $tx) = @_;

    # Request
    my $method = $tx->req->method;
    my $path   = $tx->req->url->path;

    # Response
    $tx->res->code(200);
    $tx->res->headers->content_type('text/plain');
    $tx->res->body("$method request for $path! *****");

    # Resume transaction
    $tx->resume;
}

sub start {
    my $class = shift;

    # Executable
    $ENV{MOJO_EXE} ||= (caller)[1];

    # We are the application
    $ENV{MOJO_APP} = ref $class ? $class : $class->new;

    # Start!
    Mojo::Command->start(@_);
}

1;
