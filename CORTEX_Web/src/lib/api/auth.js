import axios from 'axios';

export const sendMoney = (name, email, amount) =>
  axios.get(
    `https://UofTHacksVI.lib.id/UofTHacksVI@dev?money_request_amount=${amount}&contact_name=${name}&contact_email=${email}`
  );
