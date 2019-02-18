import React, { Component } from 'react';

import firebase from 'lib/firebase';
import { Line } from 'react-chartjs-2';
import { Segment } from 'semantic-ui-react';

class Progress extends Component {
  state = {
    usersRef: firebase.database().ref('users'),
    loadedDates: [],
    loadedLabels: [],
    loadedObjectDetectionDates: [],
    loadedObjectDetectionLabels: [],
    loading: true
  };

  componentDidMount() {
    const { currentUser } = this.props;

    if (currentUser) {
      this.addListeners(currentUser.uid);
      this.addObjectDectionListeners(currentUser.uid);
    }
  }

  addObjectDectionListeners = currentUserId => {
    let loadedDates = [];
    this.state.usersRef
      .child(currentUserId)
      .child('objectDectionProgress')
      .on('child_added', snap => {
        loadedDates.push(snap.val());

        this.setObjectDectionChartData(loadedDates);
      });
  };

  addListeners = currentUserId => {
    let loadedDates = [];
    this.state.usersRef
      .child(currentUserId)
      .child('facialExpressionProgress')
      .on('child_added', snap => {
        loadedDates.push(snap.val());
        this.setChartData(loadedDates);
      });
  };

  getMoreChartData = (currentUserId, loadedData) => {
    this.state.usersRef
      .child(currentUserId)
      .child('facialExpressionProgress')
      .child(loadedData[loadedData.length - 1].date)
      .once('value')
      .then(data => {
        if (data.val() !== null) {
          console.log(data.val());
          this.setChartData(loadedData);
        }
      });
  };

  setObjectDectionChartData = loadedData => {
    loadedData.sort((a, b) => b.date - a.date);
    let resultLabels = loadedData.map(item => {
      return new Date(item.date).toLocaleDateString();
    });

    let resultData = loadedData.map(item => {
      let score =
        ((item.correctAttempts ? item.correctAttempts : 0) /
          item.totalAttempts) *
        100;
      return score;
    });
    this.setState({
      loadedObjectDetectionDates: resultData,
      loadedObjectDetectionLabels: resultLabels,
      loading: false
    });
  };

  getSum = (total, num) => {
    return total + num;
  };

  setChartData = loadedData => {
    console.log(loadedData);
    loadedData.sort((a, b) => b.date - a.date);
    let resultLabels = loadedData.map(item => {
      return new Date(item.date).toLocaleDateString();
    });

    let resultData = loadedData.map(item => {
      let score =
        ((item.correctAttempts ? item.correctAttempts : 0) /
          item.totalAttempts) *
        100;
      return score;
    });
    this.setState({
      loadedDates: resultData,
      loadedLabels: resultLabels,
      loading: false
    });
  };

  render() {
    const {
      loadedDates,
      loadedLabels,
      loadedObjectDetectionDates,
      loadedObjectDetectionLabels,
      loading
    } = this.state;

    const data = {
      labels: loadedLabels,
      datasets: [
        {
          label: 'Progress of FacialExpressionProgress',
          fill: false,
          lineTension: 0.1,
          backgroundColor: 'rgba(75,75,192,0.4)',
          borderColor: 'rgba(75,75,192,1)',
          borderCapStyle: 'butt',
          borderDash: [],
          borderDashOffset: 0.0,
          borderJoinStyle: 'miter',
          pointBorderColor: 'rgba(75,75,192,1)',
          pointBackgroundColor: '#fff',
          pointBorderWidth: 1,
          pointHoverRadius: 5,
          pointHoverBackgroundColor: 'rgba(75,75,192,1)',
          pointHoverBorderColor: 'rgba(220,220,220,1)',
          pointHoverBorderWidth: 2,
          pointRadius: 1,
          pointHitRadius: 10,
          data: loadedDates
        }
      ]
    };

    const data2 = {
      labels: loadedObjectDetectionLabels,
      datasets: [
        {
          label: 'Progress of ObjectDetecionProgress',
          fill: false,
          lineTension: 0.1,
          backgroundColor: 'rgba(75,192,192,0.4)',
          borderColor: 'rgba(75,192,192,1)',
          borderCapStyle: 'butt',
          borderDash: [],
          borderDashOffset: 0.0,
          borderJoinStyle: 'miter',
          pointBorderColor: 'rgba(75,192,192,1)',
          pointBackgroundColor: '#fff',
          pointBorderWidth: 1,
          pointHoverRadius: 5,
          pointHoverBackgroundColor: 'rgba(75,192,192,1)',
          pointHoverBorderColor: 'rgba(220,220,220,1)',
          pointHoverBorderWidth: 2,
          pointRadius: 1,
          pointHitRadius: 10,
          data: loadedObjectDetectionDates
        }
      ]
    };

    return (
      !loading && (
        <Segment>
          <Line data={data} style={{ width: '600px', height: 'auto' }} />
          <Line data={data2} style={{ width: '600px', height: 'auto' }} />
        </Segment>
      )
    );
  }
}

export default Progress;
