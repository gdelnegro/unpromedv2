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
        $this->view->assign("dados_papel",$dadosPapel);
    }
    
    public function newAction()
    {
        $formPapel = new Application_Form_Papel('show');
        $this->view->formPapel = $formPapel;
    }


}

