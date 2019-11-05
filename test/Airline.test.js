const Airline = artifacts.require('Airline');

let instance;

beforeEach(async () => {
    instance = await Airline.new()
});

contract('Airline', accounts => {
    it('numero de vuelos disponibles', async () => {
        let total = await instance.gettotalFlights();
        assert(total > 0);
    });

    it('permitir venta  ', async () => {
        let flight = await instance.flights(0);
        let flightName =flight[0], price =flight[1];
        await  instance.buyFlight(0,{from: accounts[0],value: price})
        //recuperar vuelos para traer un mapping nos pide el array de accounts de que cuenta  
        //traer el primer indice del array
        let customerFlight =await instance.customerFlights(accounts[0],0);
        //total vuelos
        let customerTotalFlights = await instance.customerTotalFlights(accounts[0]);
        console.log(customerFlight,customerTotalFlights)
        // assert(total > 0);
    });
});