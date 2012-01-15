$(document).ready(function() {
    var lend_form = $("#lend-form");
    var borrow_form = $("#borrow-form");
    var INVALID = "invalid";
    
    // action performed when user clicks lend button
    // The form box will expand during this action
    $("#lend").click(function() {
        lend_form.fadeIn();
        borrow_form.hide();
    });

    // borrow form box expands when user clicks borrow button
    $("#borrow").click(function() {
        borrow_form.fadeIn();
        lend_form.hide();
    });

    // When the user submits the form, validate input first
    $("#lend-submit").hover(function(e) {
        var lend_friend, lend_item;
        lend_friend = $("#lend-form .chzn-select");
        lend_item = $("#lend-form .item");
        
        if (lend_friend.val() === "") {
            lend_friend.addClass(INVALID);
        } else {
            lend_friend.removeClass(INVALID);
        }

        if (lend_item.val() === "") {
            lend_item.addClass(INVALID);
        } else {
            lend_item.removeClass(INVALID);
        }
    });

    $("#borrow-submit").hover(function(e) {
        var borrow_item = $("#borrow-form .item");

        if (borrow_item.val() === "") {
            borrow_item.addClass(INVALID);
        } else {
            borrow_item.removeClass(INVALID);
        }
    });
});
