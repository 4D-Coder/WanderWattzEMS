import React from 'react';
import welcome_logo from './welcome-logo.png';
import Button from '../AppLayouts/Button';
function HomePage() {
  return (
    <div className='home-page'>
      <img src={welcome_logo} alt='WanderWattz Logo' className='logo' />
      <Button
        text='Get Started!'
        onClick={() => console.log('Redirecting~!')}
      />
    </div>
  );
}

export default HomePage;
