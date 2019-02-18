import firebase from 'firebase/app';

import 'firebase/auth';
import 'firebase/database';
import 'firebase/storage';

var config = {
  apiKey: 'AIzaSyDVaoneimKTrf_Nehlmfk54OUkM3gWm_8E',
  authDomain: 'uoft-hacks-vi.firebaseapp.com',
  databaseURL: 'https://uoft-hacks-vi.firebaseio.com',
  projectId: 'uoft-hacks-vi',
  storageBucket: 'uoft-hacks-vi.appspot.com',
  messagingSenderId: '221284062450'
};
firebase.initializeApp(config);

export default firebase;
