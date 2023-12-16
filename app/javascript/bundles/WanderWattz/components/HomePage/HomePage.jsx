import React from 'react';
import PageStructure from '../AppLayouts/PageStructure';
import Button from '../AppLayouts/Button';
import welcome_logo from './welcome-logo.png';

function HomePage() {
  return (
    <PageStructure>
      <div className='home-page'>
        <img src={welcome_logo} alt='WanderWattz Logo' className='logo' />
        <Button
          text='Get Started!'
          onClick={() => console.log('Redirecting~!')}
        />
      </div>
    </PageStructure>
  );
}

export default HomePage;
