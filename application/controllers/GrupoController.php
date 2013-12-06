<?php

class GrupoController extends Zend_Controller_Action
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
        $grupo = new Application_Model_DbTable_Grupo();
        $dadosGrupo = $grupo->pesquisarGrupo();
        $this->view->dadosGrupo = $dadosGrupo;
    }
    
    public function newAction()
    {
        $formGrupo = new Application_Form_Grupo('new');
        $this->view->formGrupo = $formGrupo;
    }
    
    public function showAction(){
        
        $formGrupo = new Application_Form_Grupo('show');
        $grupo = new Application_Model_DbTable_Grupo();
        $dadosGrupo = $grupo->pesquisarGrupo($this->_getParam('id'));
        $formGrupo->populate($dadosGrupo);
        $this->view->formGrupo = $formGrupo;
    }
    
    
    public function createAction(){
        $grupo = new Application_Model_DbTable_Grupo();
        $grupo->incluirGrupo($this->getAllParams());
        $this->_helper->redirector('index');
        
    }
   
   public function editAction(){
       $formGrupo = new Application_Form_Grupo('edit');
       $grupo = new Application_Model_DbTable_Grupo();
       $dadosGrupo = $grupo->pesquisarGrupo($this->_getParam(('id')));
       $formGrupo->populate($dadosGrupo);
       $this->view->formGrupo = $formGrupo;
   }
   
   public function updateAction()
   {
      $grupo = new Application_Model_DbTable_Grupo();
      $grupo->alterarGrupo($this->getAllParams());
      
      $this->_redirect('grupo/index');
   }
   
   public function printAction()
   {
       $this->_helper->layout()->disableLayout();
       
       $grupo = new Application_Model_DbTable_Grupo();
       $dadosGrupo = $grupo->pesquisarGrupo($this->_getParam('id'));
       $this->view->dadosGrupo = $dadosGrupo;
       
   }


}

