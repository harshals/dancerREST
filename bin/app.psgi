use lib 'lib';
use Dancer;
use Dancer::Config 'setting';
use Plack::Builder;
load_app 'dancerREST';

setting serializer => 'JSON';
setting apphandler  => 'PSGI';

Dancer::Config->load;

my $handler = sub {
    my $env = shift;
    my $request = Dancer::Request->new($env);
    Dancer->dance($request);
};

builder {

	## define your plack middlewares here
	
	mount "/debug" => builder {
	
		enable "Debug";
		enable "ConsoleLogger";
		$handler;
	};
	mount "/" => $handler;
};

