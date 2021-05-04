<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Near Cuny Colleges</title>

    <link href="stylesheet.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="index.js"></script>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBIwzALxUPNbatRBj3Xi1Uhp0fFzwWNBkE" async></script>
</head>
<body>
<%--Mapping CUNY Colleges   prompt--%>
<%--Create a Web app that shows the location of a selected CUNY college.
The app presents the user with a drop-down window with the names of the CUNY colleges.
After the user clicks on a college the map with its location is shown under the select list of colleges.
Create a MySQL database with the data in the provided csv file, cuny_addresses.csv.--%>

<%--Note: you'll need to sign up with Google to get an API key and then be
allowed to use the geocode libraries in order to get a map with marker(s) showing location(s) of a specific place(s).--%>
<div id="main">
    <h1>Cuny Colleges Near Address</h1>

    Address: <input type="text" id="addressTxBx" autofocus size="50"/>
    Minimum distance(miles):
    <select id="distanceList" onchange="runJquery()">
        <option value="0">--Select a college--</option>
        <option value="2">2</option>
        <option value="5">5</option>
        <option value="10">10</option>
        <option value="15">15</option>
        <option value="20">20</option>
        <option value="50">50</option>
    </select>

    <div id="showInfo"></div>
    <p></p>
    <div id="map"></div>
</div>
</body>
</html><%--prof api key: AIzaSyABXx9K8qI9lBzsfo5kILHq3arcCcluiro--%>