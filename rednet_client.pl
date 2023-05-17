use strict;
use warnings;
use utf8;
use experimentals;

sub getRead() {
    my $post = "get post from the server";
    return $post;
}

sub clickRead($readButton, $mainWindow) {
    my $readWindow = MainWindow->new();
    $readWindow->geometry("700x500");
    $readWindow->resizable(0,0);
    $readWindow->title("Read");

    my $readBox = $readWindow->Text(
        -width => 115,
        -height => 47,
        -font => [-family => 'clean',
                  -size => 9],
        -padx => 1,
    );

    my $post = getRead();
    $readBox->insert("end", $post);
    $readBox->pack();
}

sub getSearchRead($query) {
    my $response = $query; # get it from server;
    return $response;
}

sub clickSearchButton($seachButton, $searchEntry, $searchWindow) {
    my $searchQuery = $searchEntry->get();
    $searchEntry->delete(0, 'end');

    if($searchQuery ne "") {
        my $searchRead = MainWindow->new();
        $searchRead->geometry("700x500");
        $searchRead->resizable(0,0);
        $searchRead->title("Search Post");

        my $searchReadText = $searchRead->Text(
            -width => 115,
            -height => 47,
            -font => [-family => 'clean',
                    -size => 9],
            -padx => 1,
        );

        my $searchQueryRead = getSearchRead($searchQuery);
        $searchReadText->insert("end", $searchQueryRead);
        $searchReadText->pack();
    } else {}
}

sub clickSearch($searchButton, $mainWindow) {
    my $searchWindow = MainWindow->new();
    $searchWindow->geometry("400x100");
    $searchWindow->resizable(0,0);
    $searchWindow->title("Search");

    my $searchEntry = $searchWindow->Entry(
        -width => 40,
        -font => [
            -family => "clear",
            -size => 9
        ]
    );

    my $seachButton = $searchWindow->Button(
        -text => "Search",
        -padx => 10,
        -pady => 4,
        -font => [ size => 10 ]
    );
    $seachButton->configure(-command => [\&clickSearchButton, $searchButton, $searchEntry, $searchWindow]);

    $searchEntry->grid(-row => 0, -column => 0);
    $seachButton->grid(-row => 0, -column => 1);
}

sub postSubmit($submitButton, $postBox, $postWindow) {
    my $postContent = $postBox->get('1.0','end-1c');
    if( $postContent ne "" ) {
        # post the $postContent on to the server.
        say $postContent;
        $postWindow->destroy();
    } else {}
}

sub clickPost($postButton, $mainWindow) {
    my $postWindow = MainWindow->new();
    $postWindow->geometry("700x600");
    $postWindow->resizable(0,0);
    $postWindow->title("Post");

    my $postBox = $postWindow->Text(
        -width => 115,
        -height => 46,
        -font => [-family => 'clean', -size => 9],
        -padx => 1
    );

    my $submitButton = $postWindow->Button(
        -text => "Submit",
        -padx => 15,
        -pady => 8,
        -font => [ -size => 10 ]
    );
    $submitButton->configure(-command => [\&postSubmit, $submitButton, $postBox, $postWindow]);

    $postBox->pack();
    $submitButton->pack(-pady => 4);
}

sub clickHelp($helpButton, $mainWindow) {
    my $helpWindow = MainWindow->new();
    $helpWindow->geometry("700x500");
    $helpWindow->resizable(0,0);
    $helpWindow->title("Help");

    my $helpBox = $helpWindow->Text(
        -width => 115,
        -height => 47,
        -font => [-family => 'clean',
                  -size => 9],
        -padx => 1,
      #  -spacing1 => 1
    );

    my $helpText = 'Below text provides all the help you need to use REDNET.

If you are in a mood to write a post, click on "Post" button,
No one moderates your post.
What you want to write on the post window is up to you, only English is allowed,
Content written in other languages is not allowed, by default discarded by the server.
do not put unncessary special charechters in your post, it will be discarded by the server.
you can post any number of posts, you can post at any time.

If, you are in mood to read something, click on "Read" button.
You will get something to read in a pop up window. close the window after reading.
you can read any number of posts you want.

Search, type the query in search box and hit on search button,
it popups a windows with the most relevent post in the window. close the window after reading.
you can search any number of times you want.
Search works better when there are large number of posts.

Anonimity, your address is not saved, no usernames, you are totally anonymous here.

__END__ section, this will be automatically added to your post, displaying info about your post.

You cant see the top post, newest post. "Read" provides you with all the different posts to you.

__END__
Written: 15 May 2023 22:01:23
';
    $helpBox->insert('end', $helpText);
    $helpBox->pack();
}

sub main() {
    use Tk;

    my $mainWindow = MainWindow->new();
    $mainWindow->geometry("250x200");
    $mainWindow->resizable(0,0);
    $mainWindow->title("BLUE NET");

    my $postButton = $mainWindow->Button(-text => "Post",
                                         -relief => "flat",
                                         -padx => 10,
                                         -pady => 5,
                                         -font => [-size => 15]
                                        );
    $postButton->grid(-row => 0, -column => 0);
    $postButton->configure(-command => [\&clickPost, $postButton, $mainWindow]);

    my $searchButton = $mainWindow->Button(-text => "Search",
                                         -relief => "flat",
                                         -padx => 10,
                                         -pady => 5,
                                         -font => [-size => 15]
                                        );
    $searchButton->grid(-row => 1, -column => 0);
    $searchButton->configure(-command => [\&clickSearch, $searchButton, $mainWindow]);

    my $helpButton = $mainWindow->Button(-text => "Help",
                                         -relief => "flat",
                                         -padx => 10,
                                         -pady => 5,
                                         -font => [-size => 15]
                                        );
    $helpButton->grid(-row => 2, -column => 0);
    $helpButton->configure(-command => [\&clickHelp, $helpButton, $mainWindow]);

    my $readButton = $mainWindow->Button(-text => "Read",
                                         -relief => "flat",
                                         -padx => 10,
                                         -pady => 5,
                                         -font => [-size => 15]
                                        );
    $readButton->grid(-row => 3, -column => 0);
    $readButton->configure(-command => [\&clickRead, $readButton, $mainWindow]);

    MainLoop;
}

main();
