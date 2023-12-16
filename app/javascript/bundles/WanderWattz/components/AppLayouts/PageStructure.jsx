import React from 'react';
import styles from './PageStructure.module.css';

function PageStructure({ children }) {
  return (
    <div className={styles.page_structure}>
      { children }
    </div>
  );
}

export default PageStructure;
