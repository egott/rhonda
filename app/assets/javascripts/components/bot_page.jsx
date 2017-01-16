class BotPage extends React.Component{
  constructor() {
    super()
    this.state = {
      answer: [],
      reply: [],
      link: [],
      gif: []
        }
      }
  componentDidMount() {
    this.setState({
      answer: ["Hello, my name is Rhonda. What can I help you with today?"].concat(this.state.answer),
      reply: ["This is where your answers will be displayed, if an option is not availlable, Rhonda will send you in the right direction."].concat(this.state.reply),
      link: [""].concat(this.state.link),
      gif: [""].concat(this.state.gif)
    })
  }
  newRespond(answer,link){
    this.setState({
      answer: (this.state.answer).concat([answer]),
      link: (this.state.link).concat([link]),
      gif: (this.state.gif).concat([gif])
    })
  }
  newQuestion(question){
    this.setState({
      reply: (this.state.reply).concat([question])
    })
  }
  render() {
    return(
      <div>
        {this.state.answer.map( (answer, i) =>
          <div>
            <div>
              <Question reply={this.state.reply[i]} key={i+100}/>
              <br/><br/><br/><br/>
              <Answer answer={this.state.answer[i]} link={this.state.link[i]} gif={this.state.gif[i]} key={i}/>
            </div>
          </div>
        )}
        <br/><br/><br/>
        <Bot onNewRespond={this.newRespond.bind(this)} onNewQuestion={this.newQuestion.bind(this)}/>
      </div>
    )
  }
}
