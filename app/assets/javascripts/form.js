$(document).ready(function() {
    var lend_form = $("#lend-form");
    var borrow_form = $("#borrow-form");

    // initially hide our expanded form
    $(".expanded-form").hide();
    $(".submit").attr("disabled", true);
    
    // action performed when user clicks lend button
    // The form box will expand during this action
    $("#lend").click(function() {
        lend_form.slideDown();
        borrow_form.slideUp();
    });

    // borrow form box expands when user clicks borrow button
    $("#borrow").click(function() {
        lend_form.slideUp();
        borrow_form.slideDown();
    });

    // When the user submits the form, validate input first
    $("#submit-lend").submit(function() {
        var lend_friend, lend_item;

        lend_friend = $("#lend .friend");
        if (lend_friend.val() === "") {
            lend_friend.addClass("invalid");
            return false;
        }

        if (lend_item.val() === "") {
            lend_item.addClass("invalid)");
            return false;
        }

        lend_friend.removeClass("invalid");
        lend_item.removeClass("invalid");

        return true;
    });

    $("#submit-borrow").submit(function() {
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
    }
});
