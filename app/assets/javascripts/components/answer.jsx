class Answer extends React.Component {
  render() {
    return(
      <div>
        <div className="message-data ">
          <span className="message-data-name"><i className="fa fa-circle you"></i> Rhonda</span>
        </div>
        <div className="message you-message">
          {this.props.answer}
        </div>
      </div>
    )
  }
}
