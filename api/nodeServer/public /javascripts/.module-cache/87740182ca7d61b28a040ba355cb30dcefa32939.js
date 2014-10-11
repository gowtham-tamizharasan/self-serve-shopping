/** @jsx React.DOM */

/*Data Source*/
var data = [
  {author: "Pete Hunt", text: "This is one comment"},
  {author: "Jordan Walke", text: "This is *another* comment"}
];

var CommentList = React.createClass({displayName: 'CommentList',
  render: function() {
  	var commentNodes = this.props.data.map(function (comment) {
      return (
        Comment({author: comment.author}, 
          comment.text
        )
      );
    });
	return (
	  React.DOM.div({className: "commentList"}, 
	    commentNodes
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
        CommentList({data: data}), 
        CommentForm(null)
      )
    );
  }
});

React.renderComponent(
  CommentBox(null),
  document.getElementById('content')
);
