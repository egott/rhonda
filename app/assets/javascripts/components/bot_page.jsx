class BotPage extends React.Component{
  constructor() {
    super()
    this.state = {
      answer: [],
      reply: []
        }
      }
  componentDidMount() {
    this.setState({
      answer: ["Hello, my name is Rhonda. What can I help you with today?"].concat(this.state.answer),
      reply: ["This is where your answers will be displayed, if an option is not availlable, Rhonda will send you in the right direction."].concat(this.state.reply)
    })
  }
  newRespond(answer){
    this.setState({
      answer: (this.state.answer).concat([answer])
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
              <Answer answer={this.state.answer[i]} key={i}/>
            </div>
          </div>
        )}
        <br/><br/><br/>
        <Bot onNewRespond={this.newRespond.bind(this)} onNewQuestion={this.newQuestion.bind(this)}/>
      </div>
    )
  }
}
