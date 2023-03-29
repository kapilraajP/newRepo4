import ballerina/io;

configurable boolean isAdmin1 = ?;
configurable boolean isAdmin2 = ?;

public function main() returns error? {
    io:println(isAdmin1);
    io:println(isAdmin2);
    io:println("Successful!");
}
