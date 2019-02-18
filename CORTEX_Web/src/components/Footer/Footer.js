import React, { Component } from 'react';

import logo from 'assets/images/logo.png';
import { Container, List, Divider, Image, Segment } from 'semantic-ui-react';
class Footer extends Component {
  render() {
    return (
      <Segment
        inverted
        vertical
        style={{ margin: '5em 0em 0em', padding: '2em 2em' }}
      >
        <Container textAlign="center">
          <Image centered size="mini" src={logo} />
          <Divider inverted section />
          <List horizontal inverted divided link size="small">
            <List.Item as="a" href="#">
              Contact Us
            </List.Item>
            <List.Item as="a" href="#">
              Terms and Conditions
            </List.Item>
            <List.Item as="a" href="#">
              Privacy Policy
            </List.Item>
          </List>
        </Container>
      </Segment>
    );
  }
}

export default Footer;
