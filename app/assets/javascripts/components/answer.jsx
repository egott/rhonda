class Answer extends React.Component {
  render() {
    if (this.props.link.length > 0) {
      return(
        <div>
          <div className="message-data ">
            <span className="message-data-name"><i className="fa fa-circle you"></i> Rhonda</span>
          </div>
          <div className="message you-message">
            {this.props.answer} <p> </p>
            <a href={this.props.link}> More info.</a>
          </div>
        </div>
      )
    } else if (this.props.giph.length > 0) {
      return(
        <div>
          <div className="message-data ">
            <span className="message-data-name"><i className="fa fa-circle you"></i> Rhonda</span>
          </div>
          <div className="message you-message">
            <img src={this.props.giph} />
          </div>
        </div>
      )
    } else {
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
}
