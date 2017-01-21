<%-- 
    Document   : messenger
    Created on : Oct 22, 2015, 10:43:19 AM
    Author     : Indunil
--%>

<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.util.Type"%>
<%@page import="java.util.List"%>
<%
    List chatheads = (List) request.getAttribute("Chatheads");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Messenger</title>

        <link rel='stylesheet' href="custom_styles_scripts/lightSpeechBubbles.css"/>

        <%--<jsp:include page="BootstrapHeader.jsp"></jsp:include>--%>

        <script src="custom_styles_scripts/withinviewport.js"></script>
        <script src="custom_styles_scripts/jquery.withinviewport.js"></script>

        <style>
            .msgSenderBox{
                border: solid 1px gray;

                background: rgba(183,222,237,1);
                background: -moz-linear-gradient(top, rgba(183,222,237,1) 0%, rgba(33,180,226,0.89) 100%);
                background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba(183,222,237,1)), color-stop(100%, rgba(33,180,226,0.89)));
                background: -webkit-linear-gradient(top, rgba(183,222,237,1) 0%, rgba(33,180,226,0.89) 100%);
                background: -o-linear-gradient(top, rgba(183,222,237,1) 0%, rgba(33,180,226,0.89) 100%);
                background: -ms-linear-gradient(top, rgba(183,222,237,1) 0%, rgba(33,180,226,0.89) 100%);
                background: linear-gradient(to bottom, rgba(183,222,237,1) 0%, rgba(33,180,226,0.89) 100%);
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b7deed', endColorstr='#21b4e2', GradientType=0 );

                border-radius: 2px;                

                padding: 5px;
                margin: 5px;
                margin-bottom: 10px;

                font-size: medium;
                font-weight: bold;
                cursor: pointer;
            }

            .chatheadinfo{
                font-size:x-small;
                display: inline-block;
            }

            hr{
                -webkit-box-shadow: 0 0 10px 1px #851B73;
                box-shadow: 0 0 10px 1px #851B73;
            }

            .msgSenderBox:hover{
                -webkit-box-shadow: 0 0 10px 2px rgba(0,0,0,0.29) ;
                box-shadow: 0 0 10px 2px rgba(0,0,0,0.29) ;
                transition: all .1s ease-in-out; 
                transform: scale(1.025);
                border: solid 1px black;
            }

            .wrapper {
                position: relative;
            }

            .conHeader{
                position: relative;
                border-radius: 10px;
                padding: 10px 10px 0px 10px;
                background-color: #428BCA;
                color: white;
                font-size: medium;
                z-index: -1;
            }

            .conBody{
                display: block;                
                padding: 10px; 
                overflow-x: auto;                
                overflow-y: auto;
                max-height: 300px;        
                margin: 1% 0% 1% 0%;
            }

            .conFooter{
                position: relative;
                border-radius: 10px; 
                padding: 10px 10px 0px 10px;;
                color: black;
                margin-bottom: 10%;
                background-color: #428BCA;
            }

            textarea{
                border:none;
                margin-bottom: 5px;
                resize: vertical;
                max-height: 150px;
            }
        </style>

        <script>
            $(document).ready(function () {
                //first run
                updateChatBoxes();
                updateChatHeads();

                //auto running loop
                setInterval(function () {
                    updateChatHeads();
                    updateChatBoxes();
                }, 2500);

                //globel variable declaration
                var conversationChanged;

                var sender = null;// the other party that participates to conversation
                var receiver = null;// current logged user

                var limit = 100; //default 100
                var offset = 0; // default 0

                //globle variable to check weather the user is end of the conversation area
                var scrollEnd = null;

                //chatheads manage section
                $("#chatArea").hide();

                function closeNoConversation() {
                    $("#noConversations").remove();
                    //$("#noConversations").hide("1000");
                }

                function hideChat() {
                    //$("#chatArea").hide("fast");
                    $("#chatArea").hide();
                }

                function showChat() {
                    //$("#chatArea").show("fast");
                    $("#chatArea").show();
                }

                $("#refresh").click(function () {
                    location.reload();
                });

                $(".chatHeadsArea").delegate(".msgSenderBox", "click", function () {
                    closeNoConversation();
                    hideChat();

                    clearInterval(conversationChanged);

                    var id = this.id;
                    sender = $("#" + id).find(".senderName").val();

                    $("#conHeader").html("<div style='padding-top:3px;'><center>Conversation with " + sender.toUpperCase() + "</center></div>");

                    changeConversation();

                    showChat();

                    //updateScroll();
                    $("#newMessage").focus();

                    refreshConversation();
                });

                function refreshConversation() {
                    conversationChanged = setInterval(function () {
                        updateConversation();

                        if (scrollEnd) {
                            update();
                        }

                    }, 1000);
                }

                $(".msgSenderBox").delegate(".deleteAll", "click", function () {
                    var partner = $(this).parent().find(".senderName").val();
                    if (confirm("Delete Conversation With '" + partner + "'?")) {

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_deleteConversation",
                            dataType: 'json',
                            data: jQuery.param({partner: partner}),
                            
                            success: function (data, textStatus, jqXHR) {
                                if(data.Delete){
                                    alert("Conversation Deleted!");
                                }else{
                                    alert("Cannot Delete Conversation!");
                                }
                                
                                location.reload();
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Service not available!");
                            }
                        });
                    }
                });

                $(".msgSenderBox").delegate(".readAll", "click", function () {
                    alert("Mark As Read?");
                });

                function updateChatBoxes() {
                    $(".msgSenderBox").each(function (e) {
                        var id = this.id;

                        var sender = $("#" + id).find(".senderName").val();
                        //alert(id+sender);

                        //online-offline & last seen management
                        var curStatus = $("#" + id).find(".chatState");
                        //curStatus.addClass("user-online");
                        var infoField = $("#" + id).find(".chatheadinfo");
                        //infoField.html("");//last seen status

                        $.ajax({
                            type: "POST",
                            url: "Ajax_getChatInfo",
                            data: "member=" + sender,
                            dataType: "json",
                            //when success
                            success: function (data, textStatus, jqXHR) {
                                if (data.chat === "Online") {
                                    if (data.current === "Active") {
                                        if (curStatus.hasClass("user-offline")) {
                                            curStatus.hide("fast");
                                            curStatus.removeClass("user-offline");
                                            curStatus.addClass("user-online");
                                            curStatus.show("slow");
                                        } else if (curStatus.hasClass("user-online")) {
                                            curStatus.removeClass("user-offline");
                                            curStatus.addClass("user-online");
                                        } else {
                                            curStatus.hide("fast");
                                            curStatus.removeClass("user-offline");
                                            curStatus.removeClass("user-online");
                                            curStatus.addClass("user-online");
                                            curStatus.show("slow");
                                        }

                                        //curStatus.removeClass("user-offline");
                                        //curStatus.addClass("user-online");

                                        //infoField.html("Last Seen: " + data.lastSeen);
                                        infoField.html("Online");
                                    } else {
                                        if (curStatus.hasClass("user-offline")) {
                                            curStatus.removeClass("user-online");
                                            curStatus.addClass("user-offline");
                                        } else if (curStatus.hasClass("user-online")) {
                                            curStatus.hide("fast");
                                            curStatus.removeClass("user-online");
                                            curStatus.addClass("user-offline");
                                            curStatus.show("slow");
                                        } else {
                                            curStatus.hide("fast");
                                            curStatus.removeClass("user-online");
                                            curStatus.addClass("user-offline");
                                            curStatus.show("slow");
                                        }

                                        //curStatus.removeClass("user-online");
                                        //curStatus.addClass("user-offline");

                                        infoField.html("Last Seen: " + data.lastSeen);
                                    }
                                } else if (data.chat === "Offline") {
                                    if (curStatus.hasClass("user-offline")) {
                                        curStatus.removeClass("user-online");
                                        curStatus.addClass("user-offline");
                                    } else if (curStatus.hasClass("user-online")) {
                                        curStatus.hide("fast");
                                        curStatus.removeClass("user-online");
                                        curStatus.addClass("user-offline");
                                        curStatus.show("slow");
                                    } else {
                                        curStatus.hide("fast");
                                        curStatus.removeClass("user-online");
                                        curStatus.addClass("user-offline");
                                        curStatus.show("slow");
                                    }

                                    //curStatus.removeClass("user-online");
                                    //curStatus.addClass("user-offline");

                                    infoField.html("Last Seen: " + data.lastSeen);
                                } else {

                                    if (curStatus.hasClass("user-offline")) {
                                        curStatus.removeClass("user-online");
                                        curStatus.addClass("user-offline");
                                    } else if (curStatus.hasClass("user-online")) {
                                        curStatus.hide("fast");
                                        curStatus.removeClass("user-online");
                                        curStatus.addClass("user-offline");
                                        curStatus.show("slow");
                                    } else {
                                        curStatus.hide("fast");
                                        curStatus.removeClass("user-online");
                                        curStatus.addClass("user-offline");
                                        curStatus.show("slow");
                                    }

                                    //curStatus.removeClass("user-online");
                                    //curStatus.addClass("user-offline");
                                    infoField.html("");
                                }
                            },
                            //when error
                            error: function (jqXHR, textStatus, errorThrown) {

                                //curStatus.hide("fast");

                                //curStatus.removeClass("user-online");
                                //curStatus.removeClass("user-offline");

                                infoField.html("<span style='color:red;'>* Connection is too slow. Please wait or try after several minutes!</span>");
                            }
                        });
                        //online-offline & last seen management end
                    });
                }

                function updateChatHeads() {
                    var newList = new Array();
                    var currentList = new Array();
                    var changes = false;

                    jQuery.ajax({
                        type: "POST",
                        url: "Ajax_messengerGetChatHeads",
                        dataType: "json",
                        success: function (data) {
                            //getting new list
                            newList = data.chatHeads;
                            receiver = data.receiver;

                            //getting current list
                            $(".msgSenderBox").each(function (e) {
                                var id = this.id;
                                var sender = $("#" + id).find(".senderName").val();
                                currentList.push(sender);
                            });

                            //adding new list
                            for (var c = 0; c < newList.length; c++) {
                                if (newList[c] !== currentList[c]) {
                                    //alert("unmatch");
                                    changes = true;
                                }
                            }

                            if (changes) {
                                if (newList.length > 0) {
                                    $(".chatHeadsArea").html(null);

                                    for (var x = 0; x < newList.length; x++) {
                                        var str = newList[x];
                                        var name = str.toUpperCase();

                                        var obj = "<form><div class='msgSenderBox' id='sender" + x + "'>";
                                        obj += "<input type='hidden' class='senderName' name='sender' value='" + newList[x] + "'/>";
                                        obj += "<div class='chatState' style='display: inline-block;'></div>";
                                        obj += name;
                                        obj += "<span class='glyphicon glyphicon-trash pull-right deleteAll' data-toggle='tooltip' data-placement='bottom' title='Delete' style='color: gray;'></span>";
                                        obj += "<br>";
                                        obj += "<div class='chatheadinfo'></div>";
                                        obj += "</div></form>";

                                        console.log(obj);

                                        $(".chatHeadsArea").append(obj);
                                        $("#sender" + x).hide().slideDown("fast");
                                    }
                                }

                                updateChatBoxes();
                            }
                        }
                    });
                }
                //chatheads manage section end                


                //conversation manage section

                //this function checks wheather the scroll reached the end
                jQuery(function ($)
                {
                    $('#conBodyContent').bind('scroll', function ()
                    {
                        if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)
                        {
                            //alert('end reached');
                            scrollEnd = true;
                        } else {
                            scrollEnd = false;
                        }
                    });
                }
                );

                //call this function to scroll to bottom of the chat area
                function updateScroll() {
                    $('#conBody').animate({scrollTop: $('#conBody').prop("scrollHeight")}, 100);
                }

                //call this function to scroll to bottom of the chat area, if it is in bottom
                function update() {
                    if (scrollEnd || scrollEnd === null) {
                        $('#conBody').animate({scrollTop: $('#conBody').prop("scrollHeight")}, 100);
                    }
                }

                //this function loads all messages after selecting a new conversation
                function changeConversation() {
                    var con = $("#conBodyContent");
                    loadDone = false;

                    var dataString = "Sender=" + sender + "&Receiver=" + receiver;
                    var messages = null;

                    $.ajax({
                        type: 'POST',
                        url: "Ajax_loadConversation",
                        dataType: 'json',
                        data: dataString,
                        success: function (data, textStatus, jqXHR) {
                            messages = data.Messages;

                            con.html("");

                            if (!(messages.length >= 0)) {
                                con.html(noMessagesDOM());
                            } else {
                                for (var x = 0; x < messages.length; x++) {
                                    var message = messages[x];
                                    //alert(message);
                                    var id = message[0];
                                    var mailbox = message[1];
                                    var timeStamp = message[4];
                                    var content = message[5];
                                    var sender = message[6];
                                    var receiver = message[7];
                                    var readState = message[8];

                                    //var timeStamp = timeStamp.substring(0, timeStamp.length - 2);

                                    var deleted = false;

                                    if (mailbox === "inbox" && !sender) {
                                        deleted = true;
                                    }
                                    if (mailbox === "outbox" && !receiver) {
                                        deleted = true;
                                    }


                                    if (!deleted) {
                                        var direction = "";

                                        if (mailbox === "inbox") {
                                            direction = "you";
                                        } else {
                                            direction = "me";
                                        }

                                        var msgState = "";

                                        if (mailbox === "outbox" && readState === 1) {
                                            msgState = "Seen, ";
                                        } else if (mailbox === "outbox" && readState === 0) {
                                            msgState = "Deliverd, ";
                                        }

                                        var obj = "<div class='msg " + direction + "' id='" + id + "' data-toggle='tooltip' data-placement='bottom' title='" + msgState + timeStamp + "'>";
                                        obj += processMessage(content);
                                        obj += "</div>";

                                        con.append(obj);
                                    }
                                }
                            }

                            loadDone = true;
                            update();
                        }
                    });
                }

                function updateConversation() {
                    var dataString = "Sender=" + sender + "&Receiver=" + receiver;
                    //var newMessages = null;

                    $.ajax({
                        type: 'POST',
                        url: "Ajax_loadConversation",
                        dataType: 'json',
                        data: dataString,
                        success: function (data, textStatus, jqXHR) {
                            newMessages = data.Messages;

                            var clearedList = new Array();

                            for (var x = 0; x < newMessages.length; x++) {
                                var item = newMessages[x];
                                var itemMailbox = item[1];
                                var itemSender = item[6];
                                var itemReceiver = item[7];

                                if (itemMailbox === 'inbox' && !itemSender) {
                                    continue;
                                } else if (itemMailbox === 'outbox' && !itemReceiver) {
                                    continue;
                                } else {
                                    clearedList.push(item);
                                }
                            }

                            newMessages = clearedList.reverse();

                            if (newMessages.length > 0 && newMessages.length < 25) {
                                for (var x = 0; x < newMessages.length; x++) {
                                    var updateMsg = newMessages[x];

                                    var msgId = updateMsg[0];
                                    var mailbox1 = updateMsg[1];
                                    var tStamp = updateMsg[4];
                                    var readState1 = updateMsg[8];

                                    var msgState1 = "";

                                    if (mailbox1 === "outbox" && readState1 === 1) {
                                        msgState1 = "Seen, ";
                                    } else if (mailbox1 === "outbox" && readState1 === 0) {
                                        msgState1 = "Deliverd, ";
                                    }

                                    var title1 = msgState1 + tStamp;

                                    updateExistingMessage(msgId, title1);
                                }
                            }
                            else if (newMessages.length > 0 && newMessages.length > 25) {
                                for (var x = 0; x < 25; x++) {
                                    var updateMsg = newMessages[x];

                                    var msgId = updateMsg[0];
                                    var mailbox1 = updateMsg[1];
                                    var tStamp = updateMsg[4];
                                    var readState1 = updateMsg[8];

                                    var msgState1 = "";

                                    if (mailbox1 === "outbox" && readState1 === 1) {
                                        msgState1 = "Seen, ";
                                    } else if (mailbox1 === "outbox" && readState1 === 0) {
                                        msgState1 = "Deliverd, ";
                                    }

                                    var title1 = msgState1 + tStamp;

                                    updateExistingMessage(msgId, title1);
                                }
                            }

                            var lastMessage = null;

                            $($(".msg").get().reverse()).each(function () {
                                var current = $(this);
                                lastMessage = parseInt(current.attr('id'));
                                return false;
                            });

                            for (var x = 0; x < newMessages.length; x++) {
                                if ((newMessages[x])[0] === lastMessage) {
                                    console.log('sync:Ok');
                                    break;
                                } else {
                                    console.log('sync:new messages');
                                    var newItem = newMessages[x];

                                    var id2 = newItem[0];
                                    var mailbox2 = newItem[1];
                                    //var msg_to2 = newItem[2];
                                    //var msg_from2 = newItem[3];
                                    var timeStamp2 = newItem[4];
                                    var content2 = newItem[5];
                                    //var sender2 = newItem[6];
                                    //var receiver2 = newItem[7];
                                    var readState2 = newItem[8];

                                    var direction2;

                                    if (mailbox2 === "inbox") {
                                        direction2 = "you";
                                    } else {
                                        direction2 = "me";
                                    }

                                    var msgState2;

                                    if (mailbox2 === "outbox" && readState2 === 1) {
                                        msgState2 = "Seen, ";
                                    } else if (mailbox2 === "outbox" && readState2 === 0) {
                                        msgState2 = "Deliverd, ";
                                    }

                                    var obj2 = "<div class='msg " + direction2 + "' id='" + id2 + "' data-toggle='tooltip' data-placement='bottom' title='" + msgState2 + timeStamp2 + "'>";
                                    obj2 += processMessage(content2);
                                    obj2 += "</div>";

                                    addMessageAfter(lastMessage, obj2);
                                    update();
                                }
                            }
                        }
                    });
                }

                function noMessagesDOM() {
                    var obj = "";
                    obj += "<center id='noConversations'>";
                    obj += "<h1 style='opacity: 0.6; padding: 20px 0px 20px 0px;'>";
                    obj += "No Messages!";
                    obj += "<br>";
                    obj += "<small>Send new message to begin a conversation!</small>";
                    obj += "</h1>";
                    obj += "</center>";

                    return obj;
                }

                function updateExistingMessage() {
                    var id = arguments[0];
                    var title = arguments[1];

                    $("#" + id).attr("title", title);
                }

                function addMessageAfter() {
                    //always adss after id
                    var id = arguments[0];
                    var obj = arguments[1];

                    $(obj).animate({top: '10px'}, 500).insertAfter("#" + id);
                }

                function addMessageBefore() {
                    //always adss after id
                    var id = arguments[0];
                    var obj = arguments[1];

                    $(obj).animate({top: '10px'}, 500).insertBefore("#" + id);
                }

                function removeExistingMessage() {
                    var id = arguments[0];
                    $("#" + id).remove('fast');
                }

                function processMessage() {
                    var msg = arguments[0].replace(/\n/g, "<br>");
                    msg = "<div class='messageContent'>" + msg + "</div>";

                    return msg;
                }
                //conversation manage section end

                //send new message section start

                $("#sendMessage").submit(function (e) {
                    e.preventDefault();
                    sendNewMessage();

                    setTimeout(function () {
                        clearInterval(conversationChanged);
                        refreshConversation();
                    }, 100);
                });

                //this function sends the message if the Enter key pressed(without Shift)
                $("#newMessage").keydown(function (e) {
                    // Enter was pressed without shift key
                    if (e.keyCode === 13 && !e.shiftKey)
                    {
                        $("#sendButton").click();

                        // prevent default behavior
                        e.preventDefault();
                    }
                });

                function sendNewMessage() {
                    if (receiver !== null && sender !== null) {
                        //alert(sender+receiver);
                        var message = $("#newMessage").val();
                        var dataString = "Sender=" + receiver + "&Receiver=" + sender + "&Message=" + message;

                        $.ajax({
                            type: 'POST',
                            url: "Ajax_sendMessage",
                            dataType: "json",
                            data: dataString,
                            success: function (data, textStatus, jqXHR) {
                                //alert("Sent");

                                if (data.Sent) {
                                } else {
                                    $("#quickMessageBody").html("An error occured while sending the message!");
                                    $("#quickMessage").modal('toggle');
                                }
                                $('#sendMessage')[0].reset();
                            }
                        });

                    } else {
                        $("#quickMessageBody").html("Cannot send the message!");
                        $("#quickMessage").modal('toggle');
                    }
                }

                //send new message section end


                // update seen status start

                $("#conBody").bind("scroll", function () {
                    $(".msg.you").withinviewport().each(function () {
                        var inboxMsg = $(this).attr('id');
                        updateSeen(inboxMsg);
                    });
                });

                function updateSeen() {
                    var id = "msgID=" + arguments[0];
                    console.log(id);

                    $.ajax({
                        url: "Ajax_updateSeenState",
                        dataType: 'json',
                        type: 'POST',
                        data: id,
                        success: function (data, textStatus, jqXHR) {
                            console.log('Update done!');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log('Update failed');
                        }
                    });

                }

                // update seen status end
            });
        </script>


    </head>

    <body class="container-fluid" style="font-family: calibri;">

        <div class="row">

            <div class="col-lg-4"><!--chat head-->
                <center>
                    <h1>
                        Messages <a><span data-toggle="tooltip" data-placement="top" title="Refresh" class="glyphicon glyphicon-refresh" style="font-size: large;" id="refresh"></span></a>
                    </h1>
                    <hr>
                </center>
                <%//
                    try {
                        if (chatheads.size() > 0) {
                %>

                <div style="padding: 3px;" class="chatHeadsArea">

                    <%//
                        for (int i = 0; i < chatheads.size(); i++) {
                    %>                

                    <form>
                        <div class="msgSenderBox" id="sender<%= i%>">

                            <input type="hidden" class="senderName" name="sender" value="<%=chatheads.get(i)%>"/>

                            <div class="chatState" style="display: inline-block;"></div>
                            <%= new String(chatheads.get(i).toString()).toUpperCase()%>
                            <span class="glyphicon glyphicon-trash pull-right deleteAll" data-toggle="tooltip" data-placement="bottom" title="Delete" style="color: gray;"></span>
                            <br>
                            <div class="chatheadinfo"></div>
                            <span class="glyphicon glyphicon-check pull-right readAll hidden" data-toggle="tooltip" data-placement="bottom" title="Read" style="color: orangered;"></span>

                        </div>
                    </form>

                    <%// 
                        }
                    %>

                </div>

                <%//                    
                } else {
                %>

                <div class = "caption">
                    <center>
                        <h3 style="padding: 20px 0px 20px 0px;opacity: 0.6;">No Conversations!</h3>
                    </center>
                </div>

                <%//
                        }
                    } catch (Exception e) {
                        System.out.println("Error: " + e.getMessage());
                    }
                %>

                <hr class="hidden-lg">

            </div><!--chat head end-->

            <div class="col-lg-8" id="conversation"><!--conversation-->

                <center id="noConversations">
                    <h1 style="opacity: 0.6; padding: 20px 0px 20px 0px;">
                        Select Conversation!
                        <br>
                        <small>Select one from messages to open conversation</small>
                    </h1>
                </center>

                <div id="chatArea">

                    <div id="conHeader" class="navbar navbar-default navbar-fixed-top conHeader">

                    </div>

                    <div id="conBody" class="conBody" style="clear: both; height: fit-content; min-height: 300px;">

                        <div id="conBodyContent" style="margin-left: 10px;margin-right: 10px;">
                            <!--add me/you class to div, then enter message inside of it-->


                        </div>

                    </div>

                    <!-- Static navbar -->
                    <div id="conFooter" class="navbar navbar-default navbar-fixed-bottom conFooter">

                        <div class="conFooterContent">

                            <form class="form-horizontal" id="sendMessage">
                                <fieldset>

                                    <!-- Textarea -->
                                    <div class="form-group">

                                        <div class="col-md-12">                     
                                            <textarea class="form-control" id="newMessage" name="newMessage" placeholder="Enter New Message Here!" required=""></textarea>
                                        </div> 

                                        <div class="col-md-12">
                                            <small>Press 'Enter' to send the message, Press 'Shift + Enter' to add new line.</small>
                                            <button type="submit" class="btn btn-block btn-warning btn-sm" id='sendButton'>Send</button>
                                        </div>

                                    </div>

                                </fieldset>

                                <!--                                
                                <audio id="sentSound" class="hidden"><source src="media/Sounds/message/message_sent.wav" type="audio/wav"></audio>
                                <audio id="errorSound" class="hidden"><source src="media/Sounds/message/message_notSent.wav" type="audio/wav"></audio>
                                -->

                            </form>

                        </div>

                    </div>

                </div>

            </div><!--conversation end-->

        </div>

        <!--Model to show messages-->                      
        <div id="quickMessage" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content text-center" id="quickMessageBody" style="padding: 5px;">

                </div>
            </div>
        </div>

    </body>

</html>
