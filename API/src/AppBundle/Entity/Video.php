<?php

namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Video
 *
 * @ORM\Table(name="video")
 * @ORM\Entity(repositoryClass="AppBundle\Repository\VideoRepository")
 */
class Video
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    public $id;

    /**
     * @var string
     *
     * @ORM\Column(name="id_groupe", type="string", length=255)
     * @ORM\OneToOne(targetEntity="AppBundle\Entity\VideoGroup", mappedBy="id")
     */
    public $idGroupe;

    /**
     * @var string
     *
     * @ORM\Column(name="creator_name", type="string", length=255)
     */
    public $creatorName;

    /**
     * @var string
     *
     * @ORM\Column(name="link", type="string", length=255)
     */
    public $link;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="add_date", type="datetime")
     */
    public $addDate;


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
     * Set idGroupe
     *
     * @param string $idGroupe
     *
     * @return Video
     */
    public function setIdGroupe($idGroupe)
    {
        $this->idGroupe = $idGroupe;

        return $this;
    }

    /**
     * Get idGroupe
     *
     * @return string
     */
    public function getIdGroupe()
    {
        return $this->idGroupe;
    }

    /**
     * Set creatorName
     *
     * @param string $creatorName
     *
     * @return Video
     */
    public function setCreatorName($creatorName)
    {
        $this->creatorName = $creatorName;

        return $this;
    }

    /**
     * Get creatorName
     *
     * @return string
     */
    public function getCreatorName()
    {
        return $this->creatorName;
    }

    /**
     * Set link
     *
     * @param string $link
     *
     * @return Video
     */
    public function setLink($link)
    {
        $this->link = $link;

        return $this;
    }

    /**
     * Get link
     *
     * @return string
     */
    public function getLink()
    {
        return $this->link;
    }

    /**
     * Set addDate
     *
     * @param \DateTime $addDate
     *
     * @return Video
     */
    public function setAddDate($addDate)
    {
        $this->addDate = $addDate;

        return $this;
    }

    /**
     * Get addDate
     *
     * @return \DateTime
     */
    public function getAddDate()
    {
        return $this->addDate;
    }
}

