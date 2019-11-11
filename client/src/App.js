import React, { Component } from "react";
import getWeb3, { getGanacheWeb3, Web3 } from "./utils/getWeb3";
import Header from "./components/Header/index.js";
import Footer from "./components/Footer/index.js";
import Hero from "./components/Hero/index.js";
import Web3Info from "./components/Web3Info/index.js";

import { Loader, Button, Card, Input, Heading, Table, Form, Flex, Box, Image } from 'rimble-ui';
import { zeppelinSolidityHotLoaderOptions } from '../config/webpack';

import styles from './App.module.scss';
//import './App.css';


class App extends Component {
  constructor(props) {    
    super(props);

    this.state = {
      /////// Default state
      storageValue: 0,
      web3: null,
      accounts: null,
      route: window.location.pathname.replace("/", ""),
    };

    this.getTestData = this.getTestData.bind(this);
  }



  ///////--------------------- Functions of testFunc ---------------------------  
  getTestData = async () => {

    const { accounts, flash_loan_receiver_example, factory, execution_test, create_loan_executor, web3 } = this.state;

    console.log('=== accounts[0] ===', accounts[0]);

    const response_1 = await flash_loan_receiver_example.methods.testFunc().send({ from: accounts[0] })
    console.log('=== response of testFunc function ===', response_1);


    let tokenAddr = '0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD'    // DAI@kovan
    let aTokenAddr = '0x8Ac14CE57A87A07A2F13c1797EfEEE8C0F8F571A'   // aDAI@kovan
    let beneficiary = accounts[0]
    let riskTolerance = 1  // in Ray units, whatever those are.
    let reward = 100       // in token units.
    const response_9 = await create_loan_executor.methods.create(tokenAddr, 
                                                                 aTokenAddr, 
                                                                 beneficiary, 
                                                                 riskTolerance, 
                                                                 reward).send({ from: accounts[0] })
    console.log('=== response of create() function ===', response_9);


    // let _daiAddress = "0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD"
    // let _amount_2 = 100
    // let _referral = 1
    // const response_7 = await flash_loan_receiver_example.methods.studentDeposit(_daiAddress, _amount_2, _referral).send({ from: accounts[0] })
    // console.log('=== response of studentDeposit function ===', response_7);    

    const response_4 = await execution_test.methods.getActiveReserves().call()
    console.log('=== response of getActiveReserves() function ===', response_4); // Success

    
    let _amount_1 = 0
    const response_6 = await flash_loan_receiver_example.methods.studentflashLoan(_amount_1).send({ from: accounts[0] })
    console.log('=== response of studentflashLoan function ===', response_6);


    let _reserve = "0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD"
    let _amount = 0
    let _fee = 0

    const response_2 = await flash_loan_receiver_example.methods.studentBorrow(_reserve, _amount, _fee).send({ from: accounts[0] })
    console.log('=== response of studentBorrow function ===', response_2);  // Successful

    // let _daiAddress = "0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD"
    // let _amount = 100
    // let _referral = 1
    // let _depositorAddress = accounts[0];
    // const response_5 = await execution_test.methods.depositDAI().send({ from: _depositorAddress })
    // console.log('=== response of depositDAI() function ===', response_5);        // Fail


    let amount = 0
    const response_8 = await factory.methods.setCircuit(amount).send({ from: accounts[0] })  // Fail
    console.log('=== response of setCircuit() function ===', response_8);
  }


 
  //////////////////////////////////// 
  ///// Ganache
  ////////////////////////////////////
  getGanacheAddresses = async () => {
    if (!this.ganacheProvider) {
      this.ganacheProvider = getGanacheWeb3();
    }
    if (this.ganacheProvider) {
      return await this.ganacheProvider.eth.getAccounts();
    }
    return [];
  }

  componentDidMount = async () => {
    const hotLoaderDisabled = zeppelinSolidityHotLoaderOptions.disabled;
 
    let FlashLoanReceiverExample = {};
    let Factory = {};
    let ExecutionTest = {};
    let CreateLoanExecutor = {};
    try {
      FlashLoanReceiverExample = require("../../build/contracts/FlashLoanReceiverExample.json"); // Load ABI of contract of FlashLoanReceiverExample
      Factory = require("../../build/contracts/Factory.json"); // Load ABI of contract of Factory
      ExecutionTest = require("../../build/contracts/ExecutionTest.json"); // Load ABI of contract of ExecutionTest
      CreateLoanExecutor = require("../../build/contracts/CreateLoanExecutor.json"); // Load ABI of contract of CreateLoanExecutor
    } catch (e) {
      console.log(e);
    }

    try {
      const isProd = process.env.NODE_ENV === 'production';
      if (!isProd) {
        // Get network provider and web3 instance.
        const web3 = await getWeb3();
        let ganacheAccounts = [];

        try {
          ganacheAccounts = await this.getGanacheAddresses();
        } catch (e) {
          console.log('Ganache is not running');
        }

        // Use web3 to get the user's accounts.
        const accounts = await web3.eth.getAccounts();
        // Get the contract instance.
        const networkId = await web3.eth.net.getId();
        const networkType = await web3.eth.net.getNetworkType();
        const isMetaMask = web3.currentProvider.isMetaMask;
        let balance = accounts.length > 0 ? await web3.eth.getBalance(accounts[0]): web3.utils.toWei('0');
        balance = web3.utils.fromWei(balance, 'ether');

        let instanceFlashLoanReceiverExample = null;
        let instanceFactory = null;
        let instanceExecutionTest = null;
        let instanceCreateLoanExecutor = null;
        let deployedNetwork = null;

        // Create instance of contracts
        if (FlashLoanReceiverExample.networks) {
          deployedNetwork = FlashLoanReceiverExample.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceFlashLoanReceiverExample = new web3.eth.Contract(
              FlashLoanReceiverExample.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceFlashLoanReceiverExample ===', instanceFlashLoanReceiverExample);
          }
        }
        if (Factory.networks) {
          deployedNetwork = Factory.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceFactory = new web3.eth.Contract(
              Factory.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceFactory ===', instanceFactory);
          }
        }
        if (ExecutionTest.networks) {
          deployedNetwork = ExecutionTest.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceExecutionTest = new web3.eth.Contract(
              ExecutionTest.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceExecutionTest ===', instanceExecutionTest);
          }
        }
        if (CreateLoanExecutor.networks) {
          deployedNetwork = CreateLoanExecutor.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceCreateLoanExecutor = new web3.eth.Contract(
              CreateLoanExecutor.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceCreateLoanExecutor ===', instanceCreateLoanExecutor);
          }
        }

        if (instanceFlashLoanReceiverExample || instanceFactory || instanceExecutionTest || instanceCreateLoanExecutor) {
          // Set web3, accounts, and contract to the state, and then proceed with an
          // example of interacting with the contract's methods.
          this.setState({ 
            web3, 
            ganacheAccounts, 
            accounts, 
            balance, 
            networkId, 
            networkType, 
            hotLoaderDisabled,
            isMetaMask, 
            flash_loan_receiver_example: instanceFlashLoanReceiverExample, 
            factory: instanceFactory, 
            execution_test: instanceExecutionTest, 
            create_loan_executor: instanceCreateLoanExecutor 
          }, () => {
            this.refreshValues(
              instanceFlashLoanReceiverExample, 
              instanceFactory, 
              instanceExecutionTest, 
              instanceCreateLoanExecutor
            );
            setInterval(() => {
              this.refreshValues(instanceFlashLoanReceiverExample, 
                                 instanceFactory, 
                                 instanceExecutionTest, 
                                 instanceCreateLoanExecutor);
            }, 5000);
          });
        }
        else {
          this.setState({ web3, ganacheAccounts, accounts, balance, networkId, networkType, hotLoaderDisabled, isMetaMask });
        }
      }
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  componentWillUnmount() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  }

  refreshValues = (instanceFlashLoanReceiverExample, instanceFactory, instanceExecutionTest) => {
    if (instanceFlashLoanReceiverExample) {
      console.log('refreshValues of instanceFlashLoanReceiverExample');
    }
    if (instanceFactory) {
      console.log('refreshValues of instanceFactory');
    }
    if (instanceExecutionTest) {
      console.log('refreshValues of instanceExecutionTest');
    }
    if (instanceExecutionTest) {
      console.log('refreshValues of instanceExecutionTest');
    }
  }

  renderLoader() {
    return (
      <div className={styles.loader}>
        <Loader size="80px" color="red" />
        <h3> Loading Web3, accounts, and contract...</h3>
        <p> Unlock your metamask </p>
      </div>
    );
  }

  renderDeployCheck(instructionsKey) {
    return (
      <div className={styles.setup}>
        <div className={styles.notice}>
          Your <b> contracts are not deployed</b> in this network. Two potential reasons: <br />
          <p>
            Maybe you are in the wrong network? Point Metamask to localhost.<br />
            You contract is not deployed. Follow the instructions below.
          </p>
        </div>
      </div>
    );
  }

  renderInstructions() {
    return (
      <div className={styles.wrapper}>
        <Hero />
      </div>
    );
  }

  renderFlashLoanForStudents() {
    return (
      <div className={styles.wrapper}>
      {!this.state.web3 && this.renderLoader()}
      {this.state.web3 && 
        !this.state.flash_loan_receiver_example && 
        !this.state.factory && 
        !this.state.execution_test && 
        this.renderDeployCheck('flash_loan_receiver_example') && 
        this.renderDeployCheck('factory')  && 
        this.renderDeployCheck('execution_test') 
      }
      {this.state.web3 && 
       this.state.flash_loan_receiver_example && 
       this.state.factory && 
       this.state.execution_test && (
        <div className={styles.contracts}>

          <h2>Flashloan for students</h2>

            <div className={styles.widgets}>
              <Card width={'30%'} bg="primary">

                <h4>Create Loan by using flashloan</h4>

                <Image
                  alt="random unsplash image"
                  borderRadius={8}
                  height="100%"
                  maxWidth='100%'
                />

                <span style={{ padding: "20px" }}></span>

                <br />

                <Button size={'small'} onClick={this.getTestData}> executeOperation </Button>
              </Card>
            </div>

        </div>
      )}
      </div>
    );
  }

  render() {
    return (
      <div className={styles.App}>
        <Header />
          {this.state.route === '' && this.renderInstructions()}
          {this.state.route === 'flash_loan_for_students' && this.renderFlashLoanForStudents()}
        <Footer />
      </div>
    );
  }
}

export default App;
