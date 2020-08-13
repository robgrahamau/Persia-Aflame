# CinC (Commander In Chief). A DCS RPC Server

An RPC (Remove Procedure Call) that opens up the Mission Scripting of Eagle Dynamics's "Digital Combat Simulator"
to the outside world.

## Installation

Install CinC into your DCS Scripts directory (e.g. Default for Openbeta: ```C:\Program Files\Eagle Dynamics\DCS World OpenBeta\Scripts```)

Use ```DO SCRIPT FILE``` to include the ```cinc_loader.lua``` file into your mission at mission start.

Start the server using ```CinCServer.start(IP_ADDRESS, PORT)``` using a ```DO SCRIPT``` or including it in your own lua files.
```IP_ADDRESS``` is the address to bind to and is a string with an IP or '*' to bind to all addresses.
```PORT``` is a number for the port you want to bind to.

## Usage

Connect to the server using a TCP connection in the language of your choice. Commands should be sent using JSON encoded text terminated
by a newline with the following format:

```JSON
{
  "name": "procedure_name",
  "arguments": {
    "argument_name": "argument_value",
    "argument_name": "argument_value"
  }
}
```

Arguments are optional depending on the procedure being called. To see if they are require or not read the procedure lua files in the api
folder and see if the function parameter is ```_``` (Not needed) or ```arguments``` needed.

For a list of procedures see the lua files in the api directory (one file per RPC call).  Responses are JSON encoded with snake_case field
names and successful responses are different per procedure and currently undocumented. Play around by calling the procedures or read the code to
find out what they are.

If an error is thrown then the the response will be the following format

```JSON
{ "error" : "error message will go here"}
```
