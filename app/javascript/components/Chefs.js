import React from "react"
import PropTypes from "prop-types"

class Chefs extends React.Component {
  render() {
    const hasComments = (id, commentId, comment) => {
      if (id == commentId) {
        renderComment(comment)
      }
    }
    const renderComment = (chef, comments) => {
      if (chef.comments) {
        comments.map((comment) => {

        })
        return (
          <div>
            Comments: {comment.description}
          </div>
        )
      }
    }

    return (
      <div>
        <h1>All Chefs</h1>

        <ul>

          {this.props.chefs.map((chef) => (



            <li key={chef.id}>
              {hasComments(chef.id, comment)}
              <strong>{chef.chefname}
              </strong>
              :
            <em>{chef.email}</em>
            </li>
          ))}
        </ul>
      </div>

    );
  }
}

Chefs.propTypes = {
  chefs: PropTypes.array.isRequired,
  comments: PropTypes.array.isRequired
};

export default Chefs

