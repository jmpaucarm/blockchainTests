pragma solidity ^0.4.24;

contract  Airline {

    address public owner;

struct Customer{
    string name;
    uint loyaltyPoints;
    uint totalFlyights;
}

struct Flight{
    string name;
    uint256 price;
}

Flight[] public flights;
mapping(address => Customer) customers;//clientes  hay que realizar una accion recursiva
mapping (address => Flight[]) public customerFlights;// hacer un array de ventas ???
mapping(address => uint) public customerTotalFlights;
event flightPurhcased(address indexed customer ,uint price);

     constructor() public {
        owner =msg.sender;
        flights.push(Flight('Tokio',4 ether));
        flights.push(Flight('Germany',3 ether));
        flights.push(Flight('Madrid',2 ether));
    }

function buyFlight(uint flightIndex) public payable{
    Flight storage flight= flights[flightIndex];
    require(msg.value ==flight.price);

    Customer storage customer =customers[msg.sender];
    customer.loyaltyPoints += 5;
    customer.totalFlyights +=1;
    
    //para que pueda acceder a su array de vuelos
    customerFlights[msg.sender].push(flight);
    customerTotalFlights[msg.sender]++;
   emit  flightPurhcased(msg.sender, flight.price);
}


function gettotalFlights()  public view returns (uint){
return flights.length;

}

}