<?php

class Application_Form_UsuarioEdit extends Twitter_Form
{

    public function init()
    {
        $this->setMethod('post');
        
        /**
         * Criacao dos campos utilizados
         */
        
        $id_usuario = new Zend_Form_Element_Hidden('id_usuario');
        
        $nom_usuario = new Zend_Form_Element_Text('nom_usuario',array(
            'label' =>  'Nome do Usuario',
            'required'  =>  true,
            'filters'   =>  array('StringTrim'),
            'validators' => array(
                array('notEmpty',true, array(
                    'messages'=> array(
                        'isEmpty' => 'Este Campo nao pode ser nulo!'
                    )
                )),
            ),
        ));
        
        $num_ra_matricula = new Zend_Form_Element_Text('num_ra_matricula', array(
                    'label'     =>  'Numero Ra/Matricula:',
                    'required'  =>  true,
                    'filters'   =>  array('StringTrim'),
                    'validators' => array(
                        array('notEmpty', true, array(
                                'messages' => array(
                                    'isEmpty' => 'Campo "Login" nao pode ser nulo '
                                )
                        )),

                    ),
                ));
        
        $submit = $this->createElement('submit', 'enviar');
        $submit->setLabel('Enviar Cadastro')
                ->setIgnore(true);
                //->setAttrib('onclick', 'if (confirm("Deseja editar o cadastro?")) { document.form.submit(); } return false;');
        
        $email = $this->createElement('text', 'email');
        $email->setLabel('Email')
                ->setAttrib('size', 25)
                ->addValidator('EmailAddress')
                ->setValue('')
                ->setFilters(array( 'StringTrim' ))
                ->setRequired(true);
       
        /**
         * Adicao dos campos utilizados ao formulario
         */
        
        $this->addElements( array (
                            $id_usuario,
                            $nom_usuario,
                            $num_ra_matricula,
                            $email,
                            )
                );
        
        $this->addDisplayGroup( array('nom_usuario','num_ra_matricula','email'), 'dadosPessoais', array('legend'=>'Dados Pessoais'));
        
        $dadosPessoais = $this->getDisplayGroup('dadosPessoais');
        $dadosPessoais->setDecorators(array(
                    'FormElements',
                    'Fieldset',
                    //array('HtmlTag',array('tag'=>'div','style'=>'width:50%;;float:left;'))
        ));
        
        $this->addElement($submit);
        
    }


}
