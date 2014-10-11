/** @jsx React.DOM */

/*Data Source*/
var data = [
  {author: "Pete Hunt", text: "This is one comment"},
  {author: "Jordan Walke", text: "This is *another* comment"}
];

var CommentList = React.createClass({displayName: 'CommentList',
  render: function() {
    return (
      React.DOM.div({className: "commentList"}, 
      	Comment({author: "Pete Hunt"}, "This is one comment"), 
        Comment({author: "Jordan Walke"}, "This is *another* comment")
      )
    );
  }
});

var CommentForm = React.createClass({displayName: 'CommentForm',
  render: function() {
    return (
      React.DOM.div({className: "commentForm"}, 
        "Hello, world! I am a CommentForm."
      )
    );
  }
});

var Comment = React.createClass({displayName: 'Comment',
  render: function() {
    return (
      React.DOM.div({className: "comment"}, 
        React.DOM.h2({className: "commentAuthor"}, 
          this.props.author
        ), 
        React.DOM.p(null, this.props.children)
      )
    );
  }
});

var CommentBox = React.createClass({displayName: 'CommentBox',
  render: function() {
    return (
      React.DOM.div({className: "commentBox"}, 
      	React.DOM.h1(null, "Comments"), 
        CommentList(null), 
        CommentForm(null)
      )
    );
  }
});
React.renderComponent(
  CommentBox(null),
  document.getElementById('content')
);
