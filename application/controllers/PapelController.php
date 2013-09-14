<?php

class PapelController extends Zend_Controller_Action
{

    public function init()
    {
         /* Initialize action controller here */
        $usuario = Zend_Auth::getInstance()->getIdentity();
        //$this->view->usuario = $usuario;
        Zend_Layout::getMvcInstance()->assign('usuario', $usuario);
        
        if ( !Zend_Auth::getInstance()->hasIdentity() ) {
		return $this->_helper->redirector->goToRoute( array('controller' => 'index'), null, true);
            //$this->_redirect('/');
	}
    }

    public function indexAction()
    {
        $papel = new Application_Model_DbTable_Papel();
        $dadosPapel = $papel->pesquisarPapel();
        $this->view->dadosPapel = $dadosPapel;
    }
    
    public function newAction()
    {
        $formPapel = new Application_Form_Papel('new');
        $this->view->formPapel = $formPapel;
    }
    
    public function showAction(){
        $formPapel = new Application_Form_Papel('show');
        $papel = new Application_Model_DbTable_Papel();
        $dadosPapel = $papel->pesquisarPapel($this->_getParam('id'));
        $formPapel->populate($dadosPapel);
        $this->view->userForm = $formPapel;
    }
    
    
    public function createAction(){
        $papel = new Application_Model_DbTable_Papel();
        $papel->incluirPapel($this->getAllParams());
        $this->_helper->redirector('index');
        
    }
   
   public function editAction(){
        $formPapel = new Application_Form_Papel('edit');
        $papel = new Application_Model_DbTable_Papel();
        $dadosPapel = $papel->pesquisarPapel($this->_getParam('id'));
        $formPapel->populate($dadosPapel);
        $this->view->formPapel = $formPapel;
   }
   
   public function updateAction()
   {
      $papel = new Application_Model_DbTable_Papel();
      $papel->alterarPapel( $this->getAllParams() );
      
      $this->_redirect('papel/index');
   }


}

