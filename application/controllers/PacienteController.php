<?php

class PacienteController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
        
        $formPaciente = new Application_Form_Paciente();
        $this->view->formPaciente = $formPaciente;
    }


}

