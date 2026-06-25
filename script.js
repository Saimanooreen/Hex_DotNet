// ===============================
// Initial Flight Data
// ===============================

const initialFlights = [
    {
        time: "08:30",
        flight: "AI101",
        dest: "Delhi",
        gate: "A1",
        status: "ON TIME"
    },
    {
        time: "09:10",
        flight: "6E204",
        dest: "Mumbai",
        gate: "B3",
        status: "BOARDING"
    },
    {
        time: "10:00",
        flight: "SG500",
        dest: "Bangalore",
        gate: "C2",
        status: "DELAYED"
    },
    {
        time: "10:30",
        flight: "UK707",
        dest: "Hyderabad",
        gate: "D1",
        status: "ON TIME"
    }
];

// Copy of data
let flights = JSON.parse(JSON.stringify(initialFlights));

// Status cycle
const statusOrder = [
    "ON TIME",
    "BOARDING",
    "GATE CLOSED",
    "DEPARTED"
];

// Board container
const board = document.getElementById("board");

// Summary
const summary = document.getElementById("summary");


// ===============================
// Build Header
// ===============================

function buildHeader(){

    const header = document.createElement("div");

    header.className = "row header";

    const titles = ["Time","Flight","Destination","Gate","Status"];

    titles.forEach(text=>{

        const cell=document.createElement("div");

        cell.textContent=text;

        header.appendChild(cell);

    });

    board.appendChild(header);

}


// ===============================
// Build One Row
// ===============================

function createRow(flight,index){

    // Create row
    const row=document.createElement("div");

    row.className="row new-row";

    // Time
    const time=document.createElement("div");
    time.textContent=flight.time;

    // Flight
    const flightNo=document.createElement("div");
    flightNo.textContent=flight.flight;

    // Destination
    const dest=document.createElement("div");
    dest.textContent=flight.dest;

    // Gate
    const gate=document.createElement("div");
    gate.textContent=flight.gate;

    // Status
    const status=document.createElement("div");

    status.textContent=flight.status;

    status.id="status-"+index;

    setStatusColor(status,flight.status);

    // Attach cells

    row.appendChild(time);
    row.appendChild(flightNo);
    row.appendChild(dest);
    row.appendChild(gate);
    row.appendChild(status);

    // Attach row

    board.appendChild(row);

}


// ===============================
// Color Status
// ===============================

function setStatusColor(cell,status){

    cell.className="";

    if(status==="ON TIME")
        cell.classList.add("on-time");

    if(status==="BOARDING")
        cell.classList.add("boarding");

    if(status==="DELAYED")
        cell.classList.add("delayed");

    if(status==="GATE CLOSED")
        cell.classList.add("closed");

    if(status==="DEPARTED")
        cell.classList.add("departed");

}


// ===============================
// Render Entire Board
// ===============================

function renderBoard(){

    // Clear existing nodes

    board.textContent="";

    buildHeader();

    flights.forEach((flight,index)=>{

        createRow(flight,index);

    });

    updateSummary();

}


// ===============================
// Summary Counter
// ===============================

function updateSummary(){

    const total=flights.length;

    const boarding=flights.filter(
        f=>f.status==="BOARDING"
    ).length;

    const delayed=flights.filter(
        f=>f.status==="DELAYED"
    ).length;

    summary.textContent=
        `${total} Departures • ${boarding} Boarding • ${delayed} Delayed`;

}


// ===============================
// Add Flight
// ===============================

document.getElementById("addBtn").addEventListener("click",()=>{

    const number=flights.length+100;

    const newFlight={
        time:"11:"+Math.floor(Math.random()*60).toString().padStart(2,"0"),
        flight:"AI"+number,
        dest:"Chennai",
        gate:"E"+Math.floor(Math.random()*5+1),
        status:"ON TIME"
    };

    flights.push(newFlight);

    renderBoard();

});


// ===============================
// Reset
// ===============================

document.getElementById("resetBtn").addEventListener("click",()=>{

    flights=JSON.parse(JSON.stringify(initialFlights));

    renderBoard();

});


// ===============================
// Clock
// ===============================

function updateClock(){

    const now=new Date();

    document.getElementById("clock").textContent=
        now.toLocaleTimeString();

}

updateClock();

setInterval(updateClock,1000);


// ===============================
// Live Status Updates
// ===============================

setInterval(()=>{

    if(flights.length===0)
        return;

    const random=Math.floor(Math.random()*flights.length);

    let current=flights[random].status;

    if(current==="DELAYED"){

        current="BOARDING";

    }
    else{

        const index=statusOrder.indexOf(current);

        if(index<statusOrder.length-1){

            current=statusOrder[index+1];

        }

    }

    flights[random].status=current;

    // Update ONLY ONE CELL

    const cell=document.getElementById("status-"+random);

    if(cell){

        cell.textContent=current;

        setStatusColor(cell,current);

    }

    updateSummary();

},4000);


// Initial render

renderBoard();