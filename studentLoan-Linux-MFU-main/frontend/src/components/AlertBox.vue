<template>
    <div v-if="isVisible" class="alert-box" :class="alertType">
      <span class="alert-message">{{ message }}</span>
      <button class="close-btn" @click="closeAlert">×</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        isVisible: false, // Controls visibility of the alert
        message: '',      // Message to display in the alert
        alertType: 'success', // Default alert type
      };
    },
    methods: {
      // Method to show the alert
      showAlert(message, type = 'success') {
        this.message = message;
        this.alertType = type;
        this.isVisible = true;
  
        // Automatically hide the alert after 5 seconds
        setTimeout(() => {
          this.isVisible = false;
        }, 5000);
      },
      
      // Close the alert
      closeAlert() {
        this.isVisible = false;
      }
    }
  };
  </script>
  
  <style scoped>
  /* Basic styling for the alert box */
  .alert-box {
    position: fixed;
    top: 70px;
    right: 10px;
    background-color: #4caf50;
    color: white;
    padding: 15px 30px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    font-size: 16px;
    z-index: 9999;
    opacity: 0;
    animation: fadeIn 0.5s forwards;
  }
  
  /* Animation for showing the alert */
  @keyframes fadeIn {
    0% { opacity: 0; }
    100% { opacity: 1; }
  }
  
  /* Close button styling */
  .close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
    margin-left: 15px;
    transition: transform 0.3s ease;
  }
  
  .close-btn:hover {
    transform: scale(1.2);
  }
  
  /* Customize the message */
  .alert-message {
    flex-grow: 1;
  }
  
  /* Alert types styling */
  .success {
    background-color: #4caf50; /* Green for success */
  }
  
  .error {
    background-color: #f44336; /* Red for error */
  }
  
  .info {
    background-color: #2196f3; /* Blue for information */
  }
  
  .warning {
    background-color: #ff9800; /* Orange for warning */
  }
  </style>
  