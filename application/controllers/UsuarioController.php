<?php

class UsuarioController extends Zend_Controller_Action
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
        $usuario = new Application_Model_DbTable_Usuario();
        $userData = $usuario->pesquisarUsuario();
        $this->view->assign("dados_usuario",$userData);
    }
    
    public function showAction(){
        $userForm = new Application_Form_Usuario('show');
        $usuario = new Application_Model_DbTable_Usuario();
        $userData = $usuario->pesquisarUsuario($this->_getParam('id'));
        $userForm->populate($userData);
        $this->view->userForm = $userForm;
        //$this->view->assign("dados_usuario", $userData);
    }
    
    public function newAction(){
        $userForm = new Application_Form_Usuario(null, null);
        $this->view->userForm = $userForm;
    }
    
    public function createAction(){
        $usuario = new Application_Model_DbTable_Usuario();
        $usuario->incluirUsuario($this->getAllParams());
        $this->_helper->redirector('index');
    }
   
   public function editAction(){
        $userForm = new Application_Form_Usuario('edit');
        $usuario = new Application_Model_DbTable_Usuario();
        $userData = $usuario->pesquisarUsuario($this->_getParam('id'));
        $userForm->populate($userData);
        $this->view->userForm = $userForm;
   }
   
   public function updateAction()
   {
      $model = new Application_Model_DbTable_Usuario();
      $model->alterarUsuario($this->_getAllParams());
      $this->_redirect('usuario/index');
   }


}

