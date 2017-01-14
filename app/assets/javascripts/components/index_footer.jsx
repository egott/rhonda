class IndexFooter extends React.Component {
  render() {
    return(
    <div>
          <div className="banner">
          </div>
          <footer>
           <div className="container">
               <div className="row">
                   <div className="col-lg-12">
                   <p>A DBC Final Project Created By:</p>

                       <ul className="list-inline">
                           <li>
                               <a href="https://github.com/felixvdl">Felix Vandelanotte</a>
                           </li>
                           <li className="footer-menu-divider">&sdot;</li>
                           <li>
                               <a href="https://github.com/graphael7">Gibral Raphael</a>
                           </li>
                           <li className="footer-menu-divider">&sdot;</li>
                           <li>
                               <a href="https://github.com/egott">Emily Gottlieb</a>
                           </li>
                           <li className="footer-menu-divider">&sdot;</li>
                           <li>
                               <a href="https://github.com/nadavP3">Nadav Appel</a>
                           </li>
                       </ul>
                       <p className="copyright text-muted small">Dev Bootcamp NYC 2017</p>
                   </div>
               </div>
           </div>
       </footer>
    </div>
    )
  }
}
