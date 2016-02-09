<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * VideoGroup
 *
 * @ORM\Table(name="video_group")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\VideoGroupRepository")
 */
class VideoGroup
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\OneToOne(targetEntity="Video", inversedBy="idGroup")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=255)
     */
    private $name;

    /**
     * @var int
     *
     * @ORM\Column(name="id_templates", type="integer")
     */
    private $idTemplates;


    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return VideoGroup
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set idTemplates
     *
     * @param integer $idTemplates
     *
     * @return VideoGroup
     */
    public function setIdTemplates($idTemplates)
    {
        $this->idTemplates = $idTemplates;

        return $this;
    }

    /**
     * Get idTemplates
     *
     * @return int
     */
    public function getIdTemplates()
    {
        return $this->idTemplates;
    }
}

