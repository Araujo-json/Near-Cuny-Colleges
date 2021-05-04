//run colleges.jsp or jsp connection to db
function runJquery() {
    // collect input from user
    const inputAddress = $("#addressTxBx").val();
    const inputDistance = $("#distanceList").val();
    //check text boxes
    if (inputAddress !== "" && inputDistance !== "") {
        // converting address to its corresponding lat and lon
        //using Google's geoCoder
        var getcoords = new google.maps.Geocoder();
        getcoords.geocode({'address': inputAddress}, function (results, status) {
            //check respond from api
            if (status == "OK") {
                var coordinates = results[0].geometry.location;
                var lat = coordinates.lat();
                var lon = coordinates.lng();

                $.ajax({
                    url: "colleges.jsp",
                    data: "latitude=" + lat + "&longitude=" + lon + "&distance=" + inputDistance,
                    success: function (serverData) {
                        $("#showInfo").html(serverData);
                        displayMap();
                    }
                });
            }
            else
                alert("user address mot found");
        });
    } else {
        alert("enter valid address/distance");
        //set focus back to the input address text box
        $("#showInfo").val();
        //cleaning up the placeholder
        $("#showInfo").empty();
        $("#map").empty();
    }
}
//fields places map on the page extact info form the database and create marker with 'click' listeners
function displayMap() {
    let Data, college, website, address, city, state, zip, lat, lon, phone,
        Data_length;
    Data = $("#collegeList").val().split(";");
    Data_length = Data.length;
    //map options
    const options = {
        zoom: 11,//42.35843, -71.05977
        center: {lat: 40.7142700, lng: -74.0059700}
    };
    //new map
    const map = new google.maps.Map(document.getElementById("map"), options);

    for (let i = 0; i < Data_length; i++) {
        college = Data[i].split(",")[0];
        website = Data[i].split(",")[1];
        address = Data[i].split(",")[2];
        city = Data[i].split(",")[3];
        state = Data[i].split(",")[4];
        zip = Data[i].split(",")[5];
        lat = parseFloat(Data[i].split(",")[6]);
        lon = parseFloat(Data[i].split(",")[7]);
        phone = Data[i].split(",")[8];
        //info display over the marker(after click)
        const col_info = college + "<br>"
            + address + ", " + city + ", " + state + ", " + zip
            + "<br>" + phone + "<br /><a href='" + website + "'>" + website + "</a>";

        //call to a function that create markers
        addMarkers({
            coords: {lat: lat, lng: lon},
            content: col_info
            //can use custom icons
            //google have some sample in the documentation
            //iconImg:'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png'
        });
    }

    //function allows to have multiple markers
    function addMarkers(props) {
        let marker = new google.maps.Marker({
            position: props.coords,
            map: map
            //obj to handle custom icons
            //icon: props.iconImg
        });
        // if (props.iconImg)
        //     marker.setIcon(props.iconImg);
        if (props.content) {
            var infoWindow = new google.maps.InfoWindow({
                content: props.content
            });
            marker.addListener("click", function () {
                infoWindow.open(map, marker);
            });
        }

    }
}