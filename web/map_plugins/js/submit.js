function getDists() {
var dis=[];    

var i;
for (i = 0; i < 25; i++) {
if (document.getElementById(i).checked) {
    var x = document.getElementById(i).name;
    
    dis.push(x);
}
}

document.getElementById("hiddenitem").value = dis;
}