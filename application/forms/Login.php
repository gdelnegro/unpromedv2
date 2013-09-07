<?php

class Application_Form_Login extends Twitter_Form
{

    public function init()
    {
        /* Form Elements & Other Definitions Here ... */
        $this->setMethod('post');
        
        $this->setAttrib('horizontal', true);
        
        $this->addElement(
                'text', 'num_ra_matricula', array(
                    'label'     =>  'Numero Ra/Matricula:',
                    'required'  =>  true,
                    //'filters'   =>  array('digits'),
                    'validators' => array(
                        array('Digits', false, array(
                                'messages' => array(
                                    'notDigits' => "Deve conter apenas numeros",
                                    'digitsStringEmpty' => 'Campo "Login" nao pode ser nulo',
                            ))),
                        array('notEmpty', true, array(
                                'messages' => array(
                                    'isEmpty' => 'Campo "Login" nao pode ser nulo'
                                )
                        )),

                    ),
                )
                );
        
        $desc_senha = new Zend_Form_Element_Password('desc_senha',array(
                    'label' => 'Senha:',
                    'value' => '',
                    'class' => 'text-size text',
                    'required' => true,
                    'tabindex' => '13',
                    'validators' => array(
                        /*array('Digits', false, array(
                                'messages' => array(
                                    'notDigits' => "Senha com simbolo invalido",
                                    'digitsStringEmpty' => "",
                            ))),*/
                        array('notEmpty', true, array(
                                'messages' => array(
                                    'isEmpty' => 'Senha nao pode ser nula'
                                )
                        )),

                    ),
                    'filters' => array('StringTrim'),
                    //'decorators' => $this->requiredElementDecorators,
                    //'description' => '<img src="' . $baseurl . '/images/star.png" alt="required" />',
                ));
        
        $this->addElement($desc_senha);
        
        $this->addElement(
                'submit',   'enviar',   array(
                    'ignore'    =>  true,
                    'label'     => 'Login',
                )
                );
    }


}

