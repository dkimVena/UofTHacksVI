import React, { Component } from 'react';
import {
  Button,
  Container,
  Grid,
  Header,
  Icon,
  Image,
  Responsive,
  Segment,
  Visibility
} from 'semantic-ui-react';
import { connect } from 'react-redux';
import Nav from 'components/Header';
import Footer from 'components/Footer';
import firebase from 'lib/firebase';
import People from 'assets/images/people.JPG';
import Interac from 'assets/images/interac.png';
import { UserActions } from 'store/actionCreators';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import './about.scss';
const handleSignOut = () => {
  firebase
    .auth()
    .signOut()
    .then(() => console.log('signed out'));
};
const getWidth = () => {
  const isSSR = typeof window === 'undefined';
  return isSSR ? Responsive.onlyTablet.minWidth : window.innerWidth;
};
/* eslint-disable react/no-multi-comp */
/* Heads up! HomepageHeading uses inline styling, however it's not the best practice. Use CSS or styled components for
 * such things.
 */
const HomepageHeading = ({ mobile }) => (
  <Container text>
    <Header
      as="h1"
      content=" A brilliant tool to help people who are having a difficulty remember "
      inverted
      style={{
        fontSize: mobile ? '2em' : '4em',
        fontWeight: 'normal',
        marginBottom: 0,
        marginTop: mobile ? '1.5em' : '3em'
      }}
    />
    <Header
      as="h1"
      content=" Take a look for features and stories "
      inverted
      style={{
        fontSize: mobile ? '1.5em' : '1.7em',
        fontWeight: 'normal',
        marginTop: mobile ? '0.5em' : '1.5em'
      }}
    />
  </Container>
);
/* Heads up!
 * Neither Semantic UI nor Semantic UI React offer a responsive navbar, however, it can be implemented easily.
 * It can be more complicated, but you can create really flexible markup.
 */
class DesktopContainer extends Component {
  state = {};
  hideFixedMenu = () => this.setState({ fixed: false });
  showFixedMenu = () => this.setState({ fixed: true });
  sendMoney = (name, email, amount) => {
    try {
      UserActions.sendMoney(name, email, amount);
      this.setToast();
    } catch (err) {
      console.log(err);
    }
  };

  setToast = () => {
    toast('Thanks for your fund raising !');
  };

  render() {
    const { children, currentUser } = this.props;
    return (
      <Responsive
        getWidth={getWidth}
        minWidth={Responsive.onlyTablet.minWidth}
        className="app"
      >
        <Visibility
          once={false}
          onBottomPassed={this.showFixedMenu}
          onBottomPassedReverse={this.hideFixedMenu}
        >
          <Segment
            inverted
            textAlign="center"
            style={{ minHeight: 700, padding: '1em 0em' }}
            vertical
          >
            <Nav
              handleSignOut={handleSignOut}
              currentUser={currentUser}
              sendMoney={this.sendMoney}
            />
            <HomepageHeading />
          </Segment>
        </Visibility>
        {children}
        <Footer />
        <ToastContainer />
      </Responsive>
    );
  }
}

const DeskTop = connect(({ user }) => {
  const { currentUser } = user;

  return {
    currentUser
  };
})(DesktopContainer);

const ResponsiveContainer = ({ children }) => (
  <div>
    <DeskTop className="app">{children}</DeskTop>
  </div>
);
const About = () => (
  <ResponsiveContainer>
    <Segment style={{ padding: '8em 0em' }} vertical>
      <Grid container stackable verticalAlign="middle">
        <Grid.Row>
          <Grid.Column width={8}>
            <Header className="header_text" as="h4" style={{ fontSize: '2em' }}>
              "might make sense inside your head but they don't make sense when
              they come out. The words come out and I think 'that's not what I
              wanted to say. <br /> <br />
              I'm a different person to the one my wife married…I can't get
              through to the part of my brain that wants to her ask her how she
              is, give her a kiss and a cuddle. <br /> <br />
              Thanks for the app, I can always remember the time I spent with my
              husband. <br />
            </Header>
            <Header
              as="h3"
              style={{
                fontSize: '2em',
                minHeight: '20px',
                paddingBottom: '50px'
              }}
            >
              Donna, England
            </Header>
          </Grid.Column>
          <Grid.Column floated="right" width={8}>
            <Image bordered rounded size="large" width="500px" src={People} />
          </Grid.Column>
        </Grid.Row>
        <Grid.Row width="1000px">
          <Image src={Interac} />
          <Grid.Column textAlign="center" floated="left">
            <Button
              size="huge"
              style={{
                width: 500,
                minHeight: 100,
                background: 'orange',
                color: 'white',
                fontSize: '2em'
              }}
            >
              Donate For Them!
            </Button>
          </Grid.Column>
        </Grid.Row>
      </Grid>
    </Segment>
    <Segment style={{ padding: '8em 0em' }} vertical>
      <Grid container stackable verticalAlign="middle">
        <Grid.Row>
          <Grid.Column width={8}>
            <header as="h4" style={{ fontSize: '2em', paddingTop: '30px' }}>
              {' '}
              Facial Emotion Recognition{' '}
            </header>
            <p
              style={{
                fontSize: '1.33em',
                paddingTop: '30px',
                paddingRight: '30px'
              }}
            >
              By scanning objects around you with the camera, the app will give
              multiple possible selections for the name of objects. <br />
              You can also check the progess of the day and average time of
              recognition.
            </p>
          </Grid.Column>
          <Grid.Column width={8}>
            <header as="h4" style={{ fontSize: '2em', paddingTop: '30px' }}>
              {' '}
              Cognitive Impairment{' '}
            </header>
            <p style={{ fontSize: '1.33em', paddingTop: '30px' }}>
              Magnifying Glass 2 _ lets people point their phone at various
              objects and attempt to correctly identify it through a quiz like
              interface.
            </p>
          </Grid.Column>
        </Grid.Row>
      </Grid>
    </Segment>
  </ResponsiveContainer>
);
export default About;
