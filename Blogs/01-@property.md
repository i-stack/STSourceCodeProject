gRPC Examples

## Basic examples

- [Hello world](src/main/java/io/grpc/examples/helloworld)

- [Route guide](src/main/java/io/grpc/examples/routeguide)

- [Metadata](src/main/java/io/grpc/examples/header)

- [Error handling](src/main/java/io/grpc/examples/errorhandling)

- [Compression](src/main/java/io/grpc/examples/experimental)

- [Flow control](src/main/java/io/grpc/examples/manualflowcontrol)

- [Json serialization](src/main/java/io/grpc/examples/advanced)

## server-side streaming in ./grpc-java/examples/src/main

1、cd grpc-java/examples

2、Compile the client and server:

./gradlew installDist

3、Run the server:

./build/install/examples/bin/hello-world-server

INFO: Server started, listening on 50051

4、From another terminal, run the client:

./build/install/examples/bin/hello-world-client

5、Update the gRPC service 

Open src/main/proto/helloworld.proto

6、Update the server

src/main/java/io/grpc/examples/helloworld/HelloWorldServer.java

7、Update the client

src/main/java/io/grpc/examples/helloworld/HelloWorldClient.java

8、Run the updated app 

repeat 2、3、4
