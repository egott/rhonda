class Question extends React.Component {
  render() {
    return(
    <div>
      <div className="message-data align-right">
        <span className="message-data-name">You</span> <i className="fa fa-circle me"></i>
      </div>
      <div className="message me-message float-right">  {this.props.reply} </div>
    </div>
    )
  }
}
