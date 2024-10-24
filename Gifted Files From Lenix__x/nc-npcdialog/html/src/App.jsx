import '../public/css/App.css'

import { useState, useEffect, useMemo } from 'react'
import Emit from './Emit'

import { TiArrowSortedUp } from "react-icons/ti";
import circle from '../public/circle.png'

const App = () => {
  const [modalQuestion, setModalQuestion] = useState({name: null,job: null,text: null,buttons: null})
  const [modal, setModal] = useState([])
  const [markers, setMarkers] = useState({})
  const [removeMarkerIndex, setRemoveMarkerIndex] = useState(null)
  const [text, setText] = useState(null)

  useEffect(() => {
    const message = e => {
      let type = e.data.type
      switch (type) {
        case "OPEN_MODAL":
          setModalQuestion({
            name: e.data.name,
            job: e.data.job,
            text: e.data.text,
            buttons: e.data.buttons
          })
          break;
        case "CLOSE_MODAL":
          setModalQuestion({name: null,job: null,text: null,buttons: null})
          setModal([])
          break;
        case "ADD_MARKER":
          setMarkers((prev) => {
            return {
              ...prev,
              [e.data.index]: {
                id: e.data.index,
                position: e.data.position,
              },
            }
          })
          break;
        case "REMOVE_MARKER":
          setRemoveMarkerIndex(e.data.index)
          break;
        case "ADD_TEXT":
          setText(e.data.content)
          break;
        case "REMOVE_TEXT":
          setText(null)
          break;
        default: break;
      }
    }

    window.addEventListener('message', message)
    return () => {window.removeEventListener('message', message)}
  }, [])

  useEffect(() => {
    const keyhandle = e => {
      if (e.key == 'Escape') {
        Emit('modalClose', {}, () => {})
      }else {
        Object.keys(modalQuestion.buttons).sort().map((key) => {
          const modalButton = modalQuestion.buttons[key]
          if (modalButton.button == e.key) {
            setModalQuestion((prev) => {
              return {
                ...prev,
                buttons: {
                  ...prev.buttons,
                  [key]: {
                    ...prev.buttons[key],
                    selected: true,
                  },
                },
              };
            });
            setTimeout(() => {
              Emit('modalCallback', {option: key}, () => {})
            }, 250);
          }
        })
      }
    }

    window.addEventListener('keyup', keyhandle)
    return () => {window.removeEventListener('keyup', keyhandle)}
  }, [[], modalQuestion])

  useEffect(() => {
    if (modalQuestion.name !== null) {
      setModal(renderModal(modalQuestion.name, modalQuestion.job, modalQuestion.text, modalQuestion.buttons))
    }
  }, [modalQuestion])

  useEffect(() => {
    if (removeMarkerIndex !== null) {
      setTimeout(() => {
        setMarkers((prev) => {
          const updatedMarkers = { ...prev };
          delete updatedMarkers[removeMarkerIndex];
          return updatedMarkers;
        })
        setRemoveMarkerIndex(null)
      }, 250);
    }
  }, [removeMarkerIndex, markers])

  const renderModal = (name,job,text,buttons) => {
    return (
      <div className="modal">
        <div className="modal-header">
          <div className="npc-name">
            <span>{name.firstname}</span>
            <span>{name.lastname}</span>
          </div>
          <div className="npc-job">
            <span>{job}</span>
          </div>
        </div>

        <div className="modal-text">
          <span>{text}</span>
          <TiArrowSortedUp className='icon' />
        </div>

        <div className="modal-buttons">
        {
          Object.keys(buttons).sort().map((key) => {
            const button = buttons[key]
            return (
              <div className={`button ${button.selected ? 'select' : ''}`} key={key} onClick={e => (
                setModalQuestion((prev) => {
                  return {
                    ...prev,
                    buttons: {
                      ...prev.buttons,
                      [key]: {
                        ...prev.buttons[key],
                        selected: true,
                      },
                    },
                  };
                }),
                setTimeout(() => {
                  Emit('modalCallback', {option: key}, () => {})
                }, 250)
              )}>
                <div className={`select-button ${button.selected ? 'select' : ''}`}>
                  <span>{button.button}</span>
                </div>
                <span>{button.label}</span>
              </div>
            )
          })
        }
        </div>
      </div>
    )
  }

  const renderMarker = useMemo(() => {
    return Object.keys(markers).sort().map((key) => {
      const marker = markers[key]
      const fadeOut = key == removeMarkerIndex ? 'fadeOut' : null
      return (
        <div className={`marker ${fadeOut}`} key={key} style={{left: `${marker.position.x * 100}%`,top: `${(marker.position.y * 100)}%`,right: `${marker.position.x * 100}%`,bottom: `${(marker.position.y * 100)}%`,position: 'absolute',}}>
          <img style={{width: `${(marker.position.d * 2) / 2}vh`}} src={circle} alt="marker" />
        </div>
      )
    })
  }, [markers, removeMarkerIndex])

  const renderText = useMemo(() => {
    if (text == null) return null
    return (
      <div className="interactive" style={{
        position: 'absolute',
        left: `${text.x * 100}%`,
        top: `${text.y * 100}%`,
        right: `${text.x * 100}%`,
        bottom: `${text.y * 100}%`,
      }}>
        <div className="i-button">
          <span>{text.l}</span> 
          <div className="bottom"></div>
        </div>
        <div className="i-text">
          <span>{text.t}</span>
        </div>
      </div>
    )
  }, [text])

  return (
      Object.keys(modal).length <= 0 ? (
        <div className="others">{renderMarker}{renderText}</div>
      ) : (
        <div className="app fadeIn">{modal}</div>
      )
    
  )
}

export default App
