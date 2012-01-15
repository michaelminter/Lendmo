$(document).ready(function() {
    var lend_form = $("#lend-form");
    var borrow_form = $("#borrow-form");

    // hide our forms before the user clicks the buttons, and disable
    // the submit buttons
    var init = function() {
        lend_form.hide();
        borrow_form.hide();
    };

    init();
    
    // action performed when user clicks lend button
    // The form box will expand during this action
    $("#lend").click(function() {
        if (  lend_form.css("display") === "none" &&
            borrow_form.css("display") === "none") {

            lend_form.slideDown();
        }
        else {
            lend_form.show();
        }
        borrow_form.hide();
    });

    // borrow form box expands when user clicks borrow button
    $("#borrow").click(function() {
        if (  lend_form.css("display") === "none" &&
            borrow_form.css("display") === "none") {

            borrow_form.slideDown();
        }
        else {
            borrow_form.show();
        }
        lend_form.hide();
    });

    // When the user submits the form, validate input first
    $("#lend-form :submit").submit(function() {
        var lend_friend, lend_item;
        lend_friend = $("#lend .friend");
        borrow_friend = $("#borrow .friend");

        lend_friend.removeClass("invalid");
        lend_item.removeClass("invalid");

        if (lend_friend.val() === "") {
            lend_friend.addClass("invalid");
            return false;
        }

        if (lend_item.val() === "") {
            lend_item.addClass("invalid)");
            return false;
        }

        return true;
    });

    $("#borrow-form :submit").submit(function() {
        var borrow_friend, borrow_item;

        borrow_friend = $("#borrow .friend");
        if (borrow_friend.val() === "") {
            borrow_friend.addClass("invalid");
            return false;
        }

        if (borrow_item.val() === "") {
            borrow_item.addClass("invalid)");
            return false;
        }

        borrow_friend.removeClass("invalid");
        borrow_item.removeClass("invalid");

        return true;
    });
});
